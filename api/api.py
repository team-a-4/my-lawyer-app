from fastapi import FastAPI, Request
from threading import Thread
import firebase_admin
from firebase_admin import credentials
from firebase_admin import storage
from firebase_admin import firestore
import os
import openai
import base64
import json
import uvicorn 
from gpt_index import GPTSimpleVectorIndex
from fillpdf import fillpdfs
import uuid
import datetime

firebase_key_file = json.loads(base64.b64decode(os.getenv("FIREBASE_API_KEY")))
cred = credentials.Certificate(firebase_key_file)
firebase_admin.initialize_app(cred, {'storageBucket': '...'})

print("INITIALIZING FIREBASE")
bucket = storage.bucket()
db = firestore.client()
print("DONE INITIALIZING FIREBASE")

openai.organization = "..."
openai.api_key = os.getenv("OPENAI_API_KEY")

app = FastAPI()
brain2load = "---BRAIN2LOAD---"
print("LOADING " + brain2load)
index = GPTSimpleVectorIndex.load_from_disk('models/' + brain2load + '.json')
print(brain2load + " DONE LOADING")

@app.get('/')
async def home():
    return "Hello. I am alive!"


@app.get('/ping')
async def ping():
    print("PING REQUEST")
    return "pong"


@app.post('/message')
async def process_message(request: Request):
    _request = await request.json()
    message = _request.get('message')
    chatID = _request.get('chatID')
    debug = _request.get('debug')

    form_data = {}
    
    accident_keywords = ["accident", "insurance"]
    if any(word in message for word in accident_keywords):
        form_data = {"title" : "Do you wish to fill a claim form?","actions":[{"data":"yes", "action":"fill_insurance_claim"},{"data":"no", "action":"cancel"}]}
    
    print(f'MESSAGE REQUEST -> {_request}')
   
    # FETCH MESSAGES
    doc_ref = db.collection('chat').document(chatID)
    doc = doc_ref.get()
    
    history = doc.to_dict()['messages']
    
    formated_messages = []
    for m in history:
        if m[0] == 'u':
            formated_messages.append({"role": "user", "content": m[2:]})
        elif m[0] == 'l':
            formated_messages.append({"role": "user", "content": m[2:]})
        elif m[0] == 'a':
            formated_messages.append({"role": "system", "content": m[2:]})
        else:
            print('error: ' + message)
    history = formated_messages

    
    if history is None:
        history = [{"role": "system", "content": 'I am your lawyer, I will answer any of your legal queries regarding the laws in Mauritius.'},
                   {"role": "user", "content": message}]
    else:
        history.insert(0, {"role": "system", "content": 'I am your lawyer, I will answer any of your legal queries'})
        history.append({"role": "user", "content": message})

    bot_response = "" 
    if debug == 'false':
        # Encode history messages using GPT-3.5 Turbo
        encoded_messages = []
        for message in history:
            role = message['role']
            content = message['content']
            encoded_message = f"{role}: {content}"
            encoded_messages.append(encoded_message)
        
        # Query index with the latest encoded message
        query_message = encoded_messages[-1]
        results = index.query(query_message, response_mode="compact")
        
        # Get the response from the index results
        bot_response = results.response
        print(f'RESPONSE -> {bot_response}')
    else:
        bot_response = "TEST_RESPONSE"
        print(f'RESPONSE -> {bot_response}')

    
    db.collection('chat').document(chatID).update({
        'messages': firestore.ArrayUnion(['u~' + _request.get('message'), 'a~' + bot_response])
    })
    return {'message': bot_response, 'form_data': form_data}




@app.post('/form')
async def form_request(request: Request):
    _request = await request.json()
    action = _request.get('action')
    chatID = _request.get('chatID')

    print(f'FORM REQUEST -> {_request}')
    print(action)

    msg = ""
    form = None
    if(action == "cancel"):
        msg = "Ok, Let me know in what other way i can assist you!"
    elif(action == "fill_insurance_claim"):
        msg = "Ok here is the form, please fill in your data and i will generate the document for you."
        form = {"title": "Insurance Claim" ,"fields": [["Name", "string"], ["Address", "string"], ["Telephone (Mobile)", "number"], ["Telephone (Office)", "number"], ["Telephone (Home)", "number"]], "actions":[{"data":"submit", "action":"form_filled"}]}
    else:
        msg = "Something went wrong, this action is invalid. Its Levyn fault."
    
    return {'message': msg, 'form':form}







@app.post('/form_filled')
async def form_filled(request: Request):
    _request = await request.json()
    form_id = _request.get('form_id')
    data = _request.get('data')

    print(f'FILLED FORM REQUEST -> {_request}')
    print(form_id)
    print(data)

    _filename = str(uuid.uuid4()) + '.pdf' 
    _fileurl = "www.error.com"
    
    if(form_id == "mua_insurance"):
        input_pdf_path = "docs/mua_claim.pdf"
        data_dict = fillpdfs.get_form_fields(input_pdf_path, sort=False, page_number=None)
        data_dict['Name'] = data['Name']
        data_dict['Address'] = data['Address']
        data_dict['M'] = data['Telephone (Mobile)']
        data_dict['O'] = data['Telephone (Office)']
        data_dict['H'] = data['Telephone (Home)']
        
        fillpdfs.write_fillable_pdf(input_pdf_path, "outputs/mua_claim_filled.pdf", data_dict, flatten=False)
    else:
        return {"message": "Something went wrong, this form id is invalid. Its Levyn fault."}

    try:
        # Upload file to Firebase Storage
        blob = bucket.blob("generated_docs/" + _filename)
        blob.upload_from_filename("outputs/mua_claim_filled.pdf")
        _fileurl = blob.generate_signed_url(datetime.timedelta(hours=2), method='GET')
        
        print("File uploaded successfully")
    except Exception as e:
        print(f"Error uploading file: {e}")
    
    
    return {"message": "Here are the generated documents. Hope this was helpful.", "link" : _fileurl} 

def run():
    uvicorn.run(app, host='0.0.0.0', port=8080)


def start():
    t = Thread(target=run)
    t.start()

