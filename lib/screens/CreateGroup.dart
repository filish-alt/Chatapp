import 'package:chatapp/CustomUI/AvatarCard.dart';
import 'package:chatapp/CustomUI/ButtonCard.dart';
import 'package:chatapp/CustomUI/ContactCard.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/Model/ChatModel.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<ChatModel> contacts=[
       ChatModel(
         name:"Habib",
         status: "Architect",
        
       ),
        ChatModel(
         name:"leul",
         status: "lawyer",
        
       ),
        ChatModel(
         name:"filagot",
         status: "Developer",
         
       ),
           ChatModel(
         name:"edl",
         status: "Architect",
        
       ),
        ChatModel(
         name:"selam",
         status: "lawyer",
        
       ),
        ChatModel(
         name:"rahel",
         status: "Developer",
         
       ),
    ];
    List<ChatModel> groups =[];
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
       appBar: AppBar(
         title:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text("New Group", style: TextStyle(
               fontSize: 19,
               fontWeight: FontWeight.bold,
             ),),
             Text("Add Participant",
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
       body: Stack(
         children:[  
          ListView.builder(
        itemCount: contacts.length +1,
        itemBuilder:(context,index) {
      if(index ==0){
        return Container(
          height:groups.length>0?90:10,
        );
      }
        return InkWell(
          onTap: () {
             if(contacts[index-1].select == false){
                setState(() {
                  contacts[index-1].select = true;
                  groups.add(contacts[index-1]);
                });
             }
             else{
                 setState(() {
                  contacts[index-1].select = false;
                  groups.remove(contacts[index-1]);
                });
             }
          } ,
           child:ContactCard(
            contact: contacts[index-1]
         ) );
        }
         ),
      groups.length>0?
         Column( 
          children: [ Container(
            height: 75,
            color: Colors.white,
            child: ListView.builder(
              scrollDirection:Axis.horizontal ,
              itemCount: contacts.length,
              itemBuilder:(context,index) {
                if(contacts[index].select==true){
                    return InkWell(
                      onTap: () {
                        setState(() {
                          groups.remove(contacts[index]);
                           contacts[index].select = false;
                            
                        });
                      },
                      child:AvatarCard(contact: contacts[index],),
            );}
                else{
                  return Container();
                }
              }
               
              ),
          ),
          Divider(
             thickness: 1,
          )
          ]):Container(),
        ],
        )
        
        );
}}