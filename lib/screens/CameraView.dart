import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CameraView extends StatelessWidget {
  const CameraView({super.key, required this.path,required this.onImageSend});
  final Function onImageSend;
  final String path;
  static TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        
        backgroundColor: Colors.black,
        actions: [
           IconButton(onPressed: () {}, 
           icon: 
           Icon(Icons.crop_rotate,size: 27,)),

           IconButton(onPressed: () {}, 
           icon: 
           Icon(Icons.emoji_emotions_outlined,size: 27,)),
           IconButton(
            onPressed: () {}, 
           icon: 
           Icon(Icons.title,size: 27,)),
           IconButton(onPressed: () {}, 
           icon: 
           Icon(Icons.edit, size: 27,)),
        ],

      ),

      body:Container(
         width: MediaQuery.of(context).size.width,
         height:MediaQuery.of(context).size.height,
         child:Stack(
          children:[
            Container(
              width: MediaQuery.of(context).size.width,
              height:MediaQuery.of(context).size.height-150,
              child: Image.file(
                File(path),
                fit:BoxFit.cover,
              ),
            ),
            Positioned(
              bottom:0,
              child:Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 8),
                  color: Colors.black38,
             child:TextFormField(
              controller: _controller,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
                maxLines: 6,
                minLines: 1,
              decoration: InputDecoration(
                border:InputBorder.none,
                hintText: 'Add caption...',
                prefixIcon: 
                Icon(Icons.add_photo_alternate,
                color:Colors.white,
                size: 27,),
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    onImageSend(
                      path,
                      _controller.text.trim(),);
                    
                  },
                  child: CircleAvatar(
                    radius:27 ,
                    backgroundColor: Colors.tealAccent[700],
                    child:Icon(
                      Icons.check, 
                      color:Colors.white,
                      size: 28,),
                  ),
                )
              ),
            )
            ))
          ]
         ),
      )
    );
  }
}