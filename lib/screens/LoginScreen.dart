import 'package:flutter/material.dart';
import 'package:chatapp/CustomUI/ButtonCard.dart';
import 'package:chatapp/Model/ChatModel.dart';
import 'package:chatapp/screens/homescreen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
     late ChatModel sourceChat;
    List<ChatModel> chatmodels=[
    ChatModel(
      name:"Habib",
      isGroup: false,
      currentMessage: "Hello",
      time:"4:00",
      icon:"assets/person.svg",
      id:1,
    ),
    ChatModel(
      name:"Haji Gedo",
      isGroup: false,
      currentMessage: "hi haji",
      time:"10:00",
      icon:"assets/person.svg",
      id:2,
    ),
     ChatModel(
      name:"Haji Awol Arba",
      isGroup: true,
      currentMessage: "Hello haji",
      time:"10:00",
      icon:"assets/person.svg",
      id:3,
    ),
       
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:ListView.builder(
            itemCount:chatmodels.length,
            itemBuilder: (contex,index)=>InkWell(
                     onTap:(){
                       sourceChat=chatmodels.removeAt(index);
                       Navigator.pushReplacement(context,
                            MaterialPageRoute(builder:(builder)=>Homescreen(
                             chatmodels:chatmodels,
                             sourchat:sourceChat,
                       )));

                     },
                     child:ButtonCard(
                        name:chatmodels[index].name,
                        icon:Icons.person,
                        ),

        )),
    );
  }
}

