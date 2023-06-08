import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:http/http.dart' as http;
import 'package:my_lawyer/models/message.dart';

class Chat extends StatefulWidget {
  Chat({super.key, required this.chatID});

  String chatID;
  List<Message> messages = [];
  bool aiIsTyping = false;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final messageController = TextEditingController();

  // load the messages from the database
  void loadMessages() async {
    var snapshot = await FirebaseFirestore.instance
        .collection("chat")
        .doc(widget.chatID)
        .get();

    setState(() {
      widget.messages = [];
      var messages = snapshot.data()!['messages'];
      for (var message in messages) {
        widget.messages.add(Message(content: message));
      }
      widget.messages = widget.messages.reversed.toList();
    });
  }

  void sendMessage(String msg) async {
    print(msg);
    if (msg.isEmpty) return;

    // Update the messages list with the user's message
    setState(() {
      // Add the user's message to the list in front
      msg = 'u~$msg';
      Message _msg = Message(content: msg);
      widget.messages.insert(0, _msg);
      widget.aiIsTyping = true;
    });

    // Clear the text field
    messageController.clear();

    try {
      // API endpoint URL
      var url = Uri.parse('https://my-lawyer-api.sarwin.repl.co/message');

      // Request headers (if required)
      var headers = {'Content-Type': 'application/json'};

      // Request body
      String raw_msg = msg.split('~')[1];
      var body = json.encode({
        'chatID': 'TESTING',
        'message': raw_msg,
        'debug': 'true',
      });

      // Send POST request
      var response = await http.post(url, headers: headers, body: body);
      // Get response status code
      var statusCode = response.statusCode;
      print(response.body);

      // Handle the response data
      if (statusCode == 200) {
        var responseData = json.decode(response.body);
        var responseMessage = responseData['message'];

        // Update the UI with the response message
        setState(() {
          // Add the AI's message to the list in front
          responseMessage = 'a~$responseMessage';
          Message _msg = Message(content: responseMessage);
          _msg.json_data = responseData;
          widget.messages.insert(0, _msg);
        });
      } else {
        print('Request failed with status: $statusCode');
      }
    } catch (e) {
      print('Error: $e');
    }

    setState(() {
      widget.aiIsTyping = false;
    });
  }

  // init state
  @override
  void initState() {
    super.initState();
    loadMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                //showButtons = !showButtons;
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
              itemCount: widget.messages.length,
              itemBuilder: (context, index) {
                Message message = widget.messages[index];

                // Split the message into the sender and the actual message content
                var splitMessage = message.content.split('~');
                var sender = splitMessage[0];
                var content = splitMessage[1];

                if (sender == 'u') {
                  // User message
                  return ChatBubble(
                    clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
                    alignment: Alignment.topRight,
                    margin: const EdgeInsets.only(top: 20, right: 10, left: 10),
                    backGroundColor: Theme.of(context).colorScheme.primary,
                    child: Text(
                      content,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                } else if (sender == 'a') {
                  // AI message
                  return Stack(
                    children: [
                      const Positioned(
                        top: 25,
                        left: 7,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Color.fromARGB(255, 243, 33, 33),
                          child: Text(
                            'AI',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      ChatBubble(
                        clipper:
                            ChatBubbleClipper5(type: BubbleType.receiverBubble),
                        alignment: Alignment.topLeft,
                        margin:
                            const EdgeInsets.only(top: 20, left: 32, right: 10),
                        backGroundColor: Colors.grey[300],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var line
                                in content.replaceAll('\\n', '\n').split('\n'))
                              Text(line),
                            if (message.containsActions())
                              Text("\n" + message.getActionTitle()),
                            // render the buttons if the message is a question
                            if (message.containsActions())
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  for (var action in message.getActionOptions())
                                    Center(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text(action.actionTitle),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (sender == 'l') {
                  // Lawyer message
                  return Stack(
                    children: [
                      const Positioned(
                        top: 25,
                        left: 7,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.green,
                          child: Text(
                            'L',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      ChatBubble(
                        clipper:
                            ChatBubbleClipper5(type: BubbleType.receiverBubble),
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(top: 20, left: 32),
                        backGroundColor: Colors.grey[300],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var line
                                in content.replaceAll('\\n', '\n').split('\n'))
                              Text(line),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container(); // Unknown sender, return an empty container
                }
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    margin: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
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
                  child: widget.aiIsTyping == false
                      ? Container(
                          color: Theme.of(context).colorScheme.primary,
                          child: IconButton(
                            onPressed: () {
                              sendMessage(messageController.text);
                            },
                            icon: const Icon(Icons.send_rounded),
                            color: Colors.white,
                          ),
                        )
                      : Container(
                          color: Theme.of(context).colorScheme.primary,
                          child: IconButton(
                            onPressed: () {},
                            // loading icon
                            icon: const Icon(Icons.lock_clock_rounded),
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
}
