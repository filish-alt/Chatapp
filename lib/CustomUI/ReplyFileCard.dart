
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReplyFileCard extends StatelessWidget {
  const ReplyFileCard({super.key,required this.path, required this.message, required this.time});
   final String path;
   final String message;
   final String time;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: Container(
          height:MediaQuery.of(context).size.height / 2.3,
          width:MediaQuery.of(context).size.width / 1.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color:  Colors.grey[400],
          ),
          child: Card(
            margin: EdgeInsets.all(3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start ,
                children:[ 
                  Expanded(
                    child: Image.file(File(path),
                                    fit:BoxFit.fitHeight
                                    ),
                  ),
                  message.length > 0
                    ? Container(
                      height: 40,
                      padding: EdgeInsets.only(
                        left: 15,
                        top: 8,
                      ),
                      child: Text(
                        message,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
               : Container(),
              ]
              ),
          ),
        ),
      ),
    );
  }
}