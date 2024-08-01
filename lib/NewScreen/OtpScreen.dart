
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.number, required this.code});
   final String number;
   final String code;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
       appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Verify ${widget.code} ${widget.number}",
        style: TextStyle(
          color: Colors.teal[800],
          fontSize: 16.5,
        ),),
        actions: [
          IconButton(onPressed: () {},
           icon: Icon(
            Icons.more_vert),
            color: Colors.black,
            )
        ],
       ),
       
       body: Container(
        height:MediaQuery.of(context).size.height,
        width:MediaQuery.of(context).size.width,
        padding:EdgeInsets.symmetric(horizontal: 35),
        child: Column(
           children: [
            SizedBox(height: 10,),
             
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
              children: [
                TextSpan(
                   text:"We have send you an sms code",
                   style:  TextStyle(
                       color: Colors.teal[800],
                       fontSize: 16.5,
             ),
                ),
                TextSpan(
                  text: "    +" +widget.code + widget.number,
                  style:  TextStyle(
                       color: Colors.black,
                       fontSize: 14.5,
                       fontWeight: FontWeight.bold,
             ),
                ),
                TextSpan(
                  text: "   Wrong number?",
                  style:  TextStyle(
                       color: Colors.cyan[800],
                       fontSize: 14.5,
                       fontWeight: FontWeight.bold,
             ),
                ),
              ]
            )
            ),
      SizedBox(height: 10,),
      OtpTextField(
        numberOfFields: 6,
        borderColor: Color(0xFF512DA8),
        //set to true to show as box or false to show as dash
        showFieldAsBox: true, 
        //runs when a code is typed in
        onCodeChanged: (String code) {
            //handle validation or checks here           
        },
        //runs when every textfield is filled
        onSubmit: (String verificationCode){
            showDialog(
                context: context,
                builder: (context){
                return AlertDialog(
                    title: Text("Verification Code"),
                    content: Text('Code entered is $verificationCode'),
                );
                }
            );
        }, // end onSubmit
    ),
    SizedBox(height: 20,),

    Text("Enter 6-digit code",
        style:  TextStyle(
                       color: Colors.grey[800],
                       fontSize: 14,
                       fontWeight: FontWeight.bold,
             ),),
    SizedBox(height: 30,),

    Row(
      children: [
        Icon(Icons.message,
        color: Colors.teal,
        size: 24,
        ),
        SizedBox(width: 20,),
        Text("Resend SMS", 
             style:  TextStyle(
                       color: Colors.teal,
                       fontSize: 14.5,
                       fontWeight: FontWeight.bold,
             ),)
      ],
    )
           ],
        ),
       ),
    );
  }
}