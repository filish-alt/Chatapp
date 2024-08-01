import 'dart:math';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:chatapp/screens/CameraView.dart';
import 'package:chatapp/screens/videoView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

// ignore: non_constant_identifier_names
List<CameraDescription>  Cameras =[];
class CameraScrren extends StatefulWidget {
  const CameraScrren({super.key, required this.onImageSend});
  final Function onImageSend;

  @override
  State<CameraScrren> createState() => _CameraScrrenState();
}

class _CameraScrrenState extends State<CameraScrren> {
  late CameraController _cameraCotroller;

   late Future<void>  cameravalue;
   bool isRecording = false;
   bool flash =false;
   bool camerapos = false;
   bool iscamerafront =false;
   double transform=0;
   String videoPath = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cameraCotroller=CameraController(Cameras[0], ResolutionPreset.high);
    cameravalue=_cameraCotroller.initialize();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cameraCotroller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future:cameravalue,
            builder:(context,snapshot){
               if(snapshot.connectionState == ConnectionState.done){
                 return Container(
                  width:MediaQuery.of(context).size.width,
                  height:MediaQuery.of(context).size.height,
                  child:CameraPreview(_cameraCotroller));
               }  
               else{
               return Center(child:CircularProgressIndicator(),);
        }
          }),
        Positioned(
          bottom:0.0,
          child:Container(
            color :Colors.black,
            padding: EdgeInsets.only(top:5,bottom: 5),
            width:MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    IconButton(
                      icon: Icon(
                         flash? Icons.flash_on:Icons.flash_off,
                      color: Colors.white,
                    size:28,),
                    onPressed: () {
                      setState(() {
                        flash =! flash;
                      });
                     flash?_cameraCotroller.setFlashMode(FlashMode.torch):_cameraCotroller.setFlashMode(FlashMode.off);
                    },),
                    
                    GestureDetector(
                      onLongPress:()async {
                         await _cameraCotroller.startVideoRecording();
                         
                           setState(() {
                             isRecording=true;
                           });
                        // await video.saveTo(path);
                        
                        
                      },
                      onLongPressUp:() async {
               XFile videoPath=  await _cameraCotroller.stopVideoRecording();
               setState(() {
                 isRecording=false;
               });
               Navigator.push(context, MaterialPageRoute(builder:(builder)=> VideoViewPage(
                  path:videoPath.path,
               )));
                      },
                      onTap: () {
                        if(!isRecording)
                        takePhoto(context);
                      },
                      child:isRecording?Icon(Icons.radio_button_on,color: Colors.red,size: 80,):Icon(Icons.panorama_fish_eye,color: Colors.white,
                     size:70,),
                    ),
                     IconButton(
                      icon: Transform.rotate(
                        angle: transform,
                      child:Icon(Icons.flip_camera_ios, color: Colors.white,
                    size:28,),),
                    onPressed: () async{
                         setState(() {
                      iscamerafront=!iscamerafront;
                      transform=transform + pi;
                    });
                       int camerapos = iscamerafront?0:1;

                   _cameraCotroller=CameraController(
                    Cameras[0], ResolutionPreset.high);
                    cameravalue=_cameraCotroller.initialize();

                 
                    },)
                  ]
                ),
                SizedBox(
                  height: 4,
                ),
                Text("Tap for photo", style:TextStyle(
                  color:Colors.white
                ),
                textAlign: TextAlign.center,
                )
              ],
            ),
          )
      )
      ]
      
      )
    );
  }

  void takePhoto(BuildContext context)async
  {
  
    final path = join((await getTemporaryDirectory()).path, "${DateTime.now()}.png");
    
    final XFile picture = await _cameraCotroller.takePicture();

    await picture.saveTo(path);
   

    Navigator.push(context,MaterialPageRoute(
      builder: (builder)=>CameraView(path:path, onImageSend: widget.onImageSend,)));
  }
}