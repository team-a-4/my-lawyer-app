import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:http/http.dart' as http;

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> with TickerProviderStateMixin {
  final messageController = TextEditingController();
  bool showButtons = false;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  String responseMessage='';
  var chatDocId;
  List<String> chatMessages = []; // List to store chat messages

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection("chat")
          .doc(chatDocId)
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        try {
          // Handle error condition
          if (snapshot.hasError) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Something went wrong"),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
                ),
              );
            });
          } else {
            // Build the chat UI
            return Scaffold(
              appBar: AppBar(
                title: const Text('Chat'),
                actions: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        showButtons = !showButtons;
                      });
                    },
                    icon: const Icon(Icons.more_vert),
                  ),
                ],
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                  reverse: true,
                  itemCount: chatMessages.length,
                  itemBuilder: (context, index) {
                    var message = chatMessages[index];
                    if (index == chatMessages.length - 1) {
                          
                        
                      return ChatBubble(
                        clipper: ChatBubbleClipper7(type: BubbleType.sendBubble),
                        alignment: Alignment.topRight,
                        margin: const EdgeInsets.only(top: 20),
                        backGroundColor: Colors.blue,
                        child: Text(
                          responseMessage,
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    } else {
                      return ChatBubble(
                        clipper: ChatBubbleClipper7(type: BubbleType.receiverBubble),
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(top: 20),
                        backGroundColor: Colors.grey[300],
                        child: Text(message),
                      );
                    }
                  },
                ),


                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Card(
                            margin: const EdgeInsets.only(
                                left: 2, right: 2, bottom: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: TextFormField(
                              controller: messageController,
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              minLines: 1,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type a message',
                                contentPadding: EdgeInsets.only(
                                  left: 15,
                                  bottom: 12,
                                  top: 15,
                                  right: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            color: Theme.of(context).colorScheme.primary,
                            child: IconButton(
                              onPressed: () {
                                sendMessage(messageController.text);
                              },
                              icon: const Icon(Icons.send_rounded),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        } catch (e, stackTrace) {
          // Handle the exception here
          print('Error: $e');
          print(stackTrace);
          return Container(); // Return a default widget in case of error
        }

        return Container(); // Return a default widget in case of no error
      },
    );
  }

  void sendMessage(String msg) async {
  if (msg.isEmpty) return;

  try {
    // API endpoint URL
    var url = Uri.parse('https://my-lawyer-api.sarwin.repl.co/message');

    // Request headers (if required)
    var headers = {'Content-Type': 'application/json'};

    // Request body
    var body = json.encode({ 
      'chatID': 'TESTING',
      'message': msg,
      'debug': 'true',});

    // Send POST request
    var response = await http.post(url, headers: headers, body: body);
    // Get response status code
    var statusCode = response.statusCode;
    print('Response Status Code: $statusCode');

    // Handle the response data
    if (statusCode == 200) {
      var responseData = json.decode(response.body);
      responseMessage = responseData['message'];
      
    

      // Update the UI with the response message
      setState(() {
        // Add the response message to the chatMessages list
        chatMessages.add(responseMessage);
      });
    } else {
      print('Request failed with status: $statusCode');
    }
  } catch (e) {
    print('Error: $e');
  }
}

}
