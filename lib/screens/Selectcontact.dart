import 'package:chatapp/CustomUI/ButtonCard.dart';
import 'package:chatapp/CustomUI/ContactCard.dart';
import 'package:chatapp/screens/CreateGroup.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/Model/ChatModel.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({super.key});

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  @override
  Widget build(BuildContext context) {
    List<ChatModel> contacts=[
       ChatModel(
         name:"Habib",
         status: "Architect",
        
       ),
        ChatModel(
         name:"Haji Gedo",
         status: "Officer",
        
       ),
        ChatModel(
         name:"Haji Awol Arba",
         status: "oficer",
         
       ),
    ];
    return Scaffold(
       appBar: AppBar(
         title:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text("Select Contact", style: TextStyle(
               fontSize: 19,
               fontWeight: FontWeight.bold,
             ),),
             Text("251 contacts",
              style: TextStyle(
               fontSize: 13,)
               )
           ],
         ),

         actions: [
          IconButton(icon:Icon(Icons.search, size: 26,), onPressed: () {},),
          PopupMenuButton<String>(
            onSelected: (value){
               print(value);
            },
            itemBuilder: (BuildContext contesxt){
            return [
               PopupMenuItem(
                child: Text("Invite Friend"),
                value:"Invite Friend",
              ),
                 PopupMenuItem(
                  child: Text("Contacts"), 
                  value:"Contacts",
                  ),
                 PopupMenuItem(
                  child: Text("Refresh"), 
                  value:"Refresh",
                  ),
            ];
          },
          ),
         ]
       ),
       body: ListView.builder(
        itemCount: contacts.length+2,
        itemBuilder:(context,index) {
          if (index ==0){
            return InkWell (
                    onTap:(){
                      Navigator.push(context, 
                         MaterialPageRoute(builder: (builder)=> CreateGroup()));
                    },
            child : ButtonCard(name: "New group", icon: Icons.group),
            );
          } else if (index ==1){
            return ButtonCard(name: "New Contact", icon: Icons.person_add);
          } 
          return ContactCard(contact: contacts[index-2]
          );
        }));
}}