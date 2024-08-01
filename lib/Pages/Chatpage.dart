import 'package:chatapp/CustomUI/Customcard.dart';
import 'package:chatapp/Model/ChatModel.dart';
import 'package:chatapp/screens/Selectcontact.dart';
import 'package:flutter/material.dart';

class Chatpage extends StatefulWidget {
  const Chatpage({super.key, required this.chatmodels,required  this.sourchat});
  final List<ChatModel> chatmodels;
  final ChatModel sourchat;
  @override
  State<Chatpage> createState() => _ChatpageState();
}
class _ChatpageState extends State<Chatpage> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (builder) =>SelectContact()));
        },
        child: Icon(Icons.chat),
         ),
       body:ListView.builder(
           itemCount: widget.chatmodels.length,
           itemBuilder:(contex,index) =>Customcard(
           chatModel: widget.chatmodels[index],
           sourchat:widget.sourchat,
           )
         ),
    );
  }
}