//import 'dart:io';

import 'dart:convert';

import 'package:chatapp/CustomUI/OwnFileCard.dart';
import 'package:chatapp/CustomUI/Ownmessage.dart';
import 'package:chatapp/CustomUI/ReplyCard.dart';
import 'package:chatapp/CustomUI/ReplyFileCard.dart';
import 'package:chatapp/screens/CameraScrren.dart';
import 'package:chatapp/screens/CameraView.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/Model/ChatModel.dart';
import 'package:chatapp/Model/MessageModel.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

class IndividualPage extends StatefulWidget {
  const IndividualPage({super.key, required this.chatModel, required this.sourchat});
  final ChatModel chatModel;
  final ChatModel sourchat;

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  late IO.Socket socket;
  bool sendButton = false;
  List<MessageModel> messages = [];
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  ImagePicker _picker = ImagePicker();
  XFile? file;
  int popTime = 0;
  @override
  void initState() {
    super.initState();
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  void connect() {
    socket = IO.io("http://192.168.0.186:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.on('connect', (_) {
      print('Connected');
      print(socket.id);
    });

    socket.on('connect_error', (data) {
      print('Connect Error: $data');
    });

    socket.on('disconnect', (_) {
      print('Disconnected');
    });

    socket.connect();
    socket.emit('signin', widget.sourchat.id);
    socket.onConnect((data) {
      print("Connected");
      socket.on("message", (msg) {
        print(msg);
        setMessage("destination", msg["message"],msg["path"]);
      });
    });
  }

  void sendMessage(String message, int sourceId, int targetId, String path) {
    setMessage("source", message, path);
    socket.emit("message",
     {"message": message, "sourceId": sourceId, "targetId": targetId, "path":path});
  }
  

  void setMessage(String type, String message, String path) {
    MessageModel messageModel = MessageModel(
      type: type, 
      message: message, 
      path:path,
      time:DateTime.now().toString().substring(10,16));
    setState(() {
      messages.add(messageModel);
    });
     _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),curve: Curves.easeOut,);
  }

  void onImageSend(String path, String message) async {
    for(int i =0 ; i<= popTime; popTime){
      Navigator.pop(context);
    }
  var request = http.MultipartRequest("POST",Uri.parse("http/192.168.0.186:5000/route/addimage"));
  request.files.add(await http.MultipartFile.fromPath("img", path));
  request.headers.addAll({
    "Content-type" : "multipart/form-data",
  });
  http.StreamedResponse response = await request.send();
  var httpResponse = await http.Response.fromStream(response);
  var data= json.decode(httpResponse.body);
  print(data["path"]);
  print(response.statusCode);
  setMessage("source", message, path);
    socket.emit("message",
     {
      "message": message, 
     "sourceId": widget.sourchat.id, 
     "targetId": widget.chatModel.id, 
      "path":path});
     
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/whatsapp_Back.jpg',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leadingWidth: 70,
            titleSpacing: 0,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back,
                    size: 24,
                  ),
                  CircleAvatar(
                    child: SvgPicture.asset(
                      widget.chatModel.isGroup ? "assets/groups.svg" : "assets/person.svg",
                      color: Colors.white,
                      height: 36,
                      width: 36,
                    ),
                    radius: 20,
                    backgroundColor: Colors.blueGrey,
                  ),
                ],
              ),
            ),
            title: InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.all(6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.chatModel.name,
                      style: TextStyle(
                        fontSize: 18.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "last seen today 12 AM",
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(icon: Icon(Icons.videocam), onPressed: () {}),
              IconButton(icon: Icon(Icons.call), onPressed: () {}),
              PopupMenuButton<String>(
                onSelected: (value) {
                  print(value);
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      child: Text("View Contact"),
                      value: "View Contact",
                    ),
                    PopupMenuItem(
                      child: Text("Media, links, and doc"),
                      value: "Media, links, and doc",
                    ),
                    PopupMenuItem(
                      child: Text("WhatsApp web"),
                      value: "WhatsApp web",
                    ),
                    PopupMenuItem(
                      child: Text("Search"),
                      value: "Search",
                    ),
                    PopupMenuItem(
                      child: Text("Mute Notification"),
                      value: "Mute Notification",
                    ),
                  ];
                },
              ),
            ],
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: WillPopScope(
              onWillPop: () async {
                if (show) {
                  setState(() {
                    show = false;
                  });
                  return false;
                } else {
                  return true;
                }
              },
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index) {
                        if(index == messages.length)
                        {
                          return Container(
                            height: 70,
                          );
                        }
                        if (messages[index].type == "source") {
                          if (messages[index].path.length > 0){
                            return Ownfilecard(
                              path: messages[index].path,
                              message :messages[index].message,
                              time:messages[index].time ,);
                              
                          }
                          else {
                          return OwnMessageCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        }
                        } else {
                           if (messages[index].path.length > 0){
                              return ReplyFileCard();
                             }
                             else{
                          return ReplyCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                             }
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 60,
                                child: Card(
                                  margin: EdgeInsets.only(left: 2, right: 2, bottom: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: TextFormField(
                                    controller: _controller,
                                    focusNode: focusNode,
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    minLines: 1,
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        setState(() {
                                          sendButton = true;
                                        });
                                      } else {
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Type a Message",
                                      prefixIcon: IconButton(
                                        icon: Icon(Icons.emoji_emotions),
                                        onPressed: () {
                                          focusNode.unfocus();
                                          focusNode.canRequestFocus = false;
                                          setState(() {
                                            show = !show;
                                          });
                                        },
                                      ),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.attach_file),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                backgroundColor: Colors.transparent,
                                                context: context,
                                                builder: (builder) => bottomSheet(),
                                              );
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.camera_alt),

                                            onPressed: () {
                                              setState(() {
                                                 popTime = 2;
                                                      });
                                               Navigator.push(context, MaterialPageRoute(builder: (builder)=> CameraScrren(onImageSend: onImageSend,)));
                                            },
                                          ),
                                        ],
                                      ),
                                      contentPadding: EdgeInsets.all(5),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8, right: 5),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Color.fromARGB(255, 94, 181, 252),
                                  child: IconButton(
                                    icon: Icon(
                                      sendButton ? Icons.send : Icons.mic,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      if (sendButton) {
                                        _scrollController.animateTo(
                                          _scrollController.position.maxScrollExtent,
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.easeOut,
                                        );
                                        sendMessage(
                                          _controller.text, 
                                          widget.sourchat.id, 
                                          widget.chatModel.id,
                                          "");
                                        _controller.clear();
                                        setState((){
                                          sendButton=false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          show ? emojiSelect() : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.insert_drive_file, Colors.indigo, "Document", (){}),
                  SizedBox(width: 40),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera",(){
                    setState(() {
                         popTime = 3;
                       });
                    Navigator.push(context, MaterialPageRoute(builder: (builder)=> CameraScrren(onImageSend: onImageSend,)));
                  }),
                  SizedBox(width: 40),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery",
                  () async{
                       setState(() {
                         popTime = 2;
                       });
                        file =await  _picker.pickImage(source: ImageSource.gallery);
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (builder)=>CameraView(path: file!.path, onImageSend: onImageSend,)));
                  }),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio",(){}),
                  SizedBox(width: 40),
                  iconCreation(Icons.location_pin, Colors.teal, "Location", (){}),
                  SizedBox(width: 40),
                  iconCreation(Icons.person, Colors.blue, "Contact",(){}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

 Widget iconCreation(IconData icon, Color color, String text,  void Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icon,
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget emojiSelect() {
    return EmojiPicker(
      onEmojiSelected: (category, emoji) {
        print(emoji);
        setState(() {
          _controller.text = _controller.text + emoji.emoji;
        });
      },
    );
  }
}
