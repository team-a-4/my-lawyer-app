import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}
Future<void> fetchAPI() async {
  final response = await http.get(Uri.parse('https://my-lawyer-api.sarwin.repl.co/ping'));

  if (response.statusCode == 200) {
    // API request successful, process the response
    print(response.body);
  } else {
    // API request failed
    print('Error: ${response.statusCode}');
  }
}
class _ChatState extends State<Chat> with TickerProviderStateMixin{
  bool showButtons = false;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;


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



    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: [IconButton(
      onPressed: () {
         setState(() {
          showButtons = !showButtons;
         });
      },
      icon: Icon(Icons.more_vert),),],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView(
                  reverse: true,
                  
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    // IconButton(
                    //   onPressed: () {
                    //     setState(() {
                    //       showButtons = !showButtons;
                    //     });
                    //   },
                    //   icon: const Icon(Icons.add),
                    // ),
                    Expanded(
                      child: Card(
                        margin: EdgeInsets.only(left: 2, right: 2, bottom: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: TextFormField(
                          // controller: messageController,
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
                    SizedBox(width: 15),
                    CircleAvatar(
                      backgroundColor:
                          Theme.of(context).colorScheme.primary,
                      radius: 22.5,
                      child: IconButton(
                        onPressed: () {

                          fetchAPI();
                        },
                        icon: const Icon(Icons.send_rounded),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          showButtons
              ? Positioned(
                  top: 0,
                  
                  right: 10,
                  child: AnimatedBuilder(
                  animation: _slideAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: _slideAnimation.value,
                      child: child,
                    );
                  },
                  child: Container(
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                          onPressed: () {},
                          child: Icon(Icons.person),
                        ),
                        const SizedBox(height: 10.0),
                        FloatingActionButton(
                          onPressed: () {},
                          child: Icon(Icons.chair),
                        ),
                      ],
                    ),
                  ),
                )
              )
              : Container(),
        ],
      ),
    );
  }
}
