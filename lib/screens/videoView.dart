import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class VideoViewPage extends StatefulWidget {
  const VideoViewPage({super.key,  required this.path});
  final String path;
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
  

}

class _VideoViewPageState extends State<VideoViewPage>{
  late VideoPlayerController _controller;

   @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }
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
              child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
            ),
            Positioned(
              bottom:0,
              child:Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 8),
                  color: Colors.black38,
             child:TextFormField(
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
                suffixIcon: CircleAvatar(
                  radius:27 ,
                  backgroundColor: Colors.tealAccent[700],
                  child:Icon(Icons.check, color:Colors.white,size: 28,),
                )
              ),
            )
            )),
         Align(
          alignment: Alignment.center,

           child: InkWell(
             onTap: (){
              setState(() {
                _controller.value.isPlaying?_controller.pause()
                :_controller.play;
              });
             },
             child:CircleAvatar(
              radius: 33,
              backgroundColor: Colors.black38,
              child: Icon(_controller.value.isPlaying?Icons.pause:Icons.play_arrow,color: Colors.white,
              size:50,),
            ) ),)
          ]
         ),
      )
    );
  }
} 
 