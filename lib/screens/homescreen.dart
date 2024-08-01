import 'package:chatapp/Pages/Chatpage.dart';
import 'package:chatapp/Pages/CameraPage.dart';
import 'package:chatapp/Pages/StatusPage.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/Model/ChatModel.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key, required this.chatmodels, required this.sourchat});
  final List<ChatModel> chatmodels;
  final ChatModel sourchat;
  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> 
with SingleTickerProviderStateMixin {
 late TabController _controller;
       @override
  void initState() {
    // TODO: implement initState
     super.initState();
      _controller = TabController(length: 4, vsync: this, initialIndex: 1);
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
      // backgroundColor:Color(0xFF075E54),
      foregroundColor: Colors.white,
       title: Row(
            children: [
              Image.asset(
                'assets/images/logo.jpg',
                height: 40,
                // Adjust the height as needed
                fit: BoxFit.contain,
              ),
              SizedBox(width: 10), // Add some spacing between the image and the text
              Text("Asil"),
            ],
          ),
          actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          PopupMenuButton<String>(
            onSelected: (value){
               print(value);
            },
            
            itemBuilder: (BuildContext contesxt){
            return [
               PopupMenuItem(
                child: Text("New group"),
                value:"New group",
              ),
                 PopupMenuItem(
                  child: Text("New Broadcast"), 
                  value:"New broadcast",
                  ),
                 PopupMenuItem(
                  child: Text("Whatsapp web"), 
                  value:"Whats app web",
                  ),
                 PopupMenuItem(
                  child: Text("Starred Message"),
                  value:"Starred Message",
                  ),
                 PopupMenuItem(
                  child: Text("Setting"),
                  value:"Setting",),
            ];
          },
          )
         ],
         bottom : TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          
          tabs :[
            Tab(
              icon: Icon(Icons.camera_alt),
            ),
            Tab(
             // text : "CHATS",
             child: Text("CHATS",
              style: TextStyle(
               fontSize: 13,
               color: Colors.white)
               
               )
            ),
              Tab(
              //text : "STATUS",
              child: Text("STATUS",
              style: TextStyle(
               fontSize: 13,
               color: Colors.white)
               
               )
            ),
              Tab(
             child: Text("CALLS",
              style: TextStyle(
               fontSize: 13,
               color: Colors.white)
               
               )
            ),
  

          ]

         ),
      ),
       body: TabBarView(
      
        controller:_controller,
        children: [
          CameraPage(),
          Chatpage(
            chatmodels:widget.chatmodels,
            sourchat:widget.sourchat,
          ),
          StatusPage(),
          Text("Calls")
        ],

        ),
    );
  }
}
