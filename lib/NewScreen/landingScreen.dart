import 'package:chatapp/NewScreen/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height:50,
                ),
              Text("Welcome to Asil",
              style:TextStyle(
                 color: Colors.teal,
                 fontSize: 29,
                 fontWeight: FontWeight.w600,

              )
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 9,
              ),
              Image.asset(
                "assets/images/logo.jpg",
                height:340,
                width:340,
                ),
                SizedBox(
                height: MediaQuery.of(context).size.height / 7,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                
                    ),
                    children: [
                      TextSpan(
                        text: "Agree and Continue"
                      ),
                       TextSpan(
                        text: "Terms and Police",
                        style: TextStyle(
                          color: Colors.cyan,
                        )
                      ),
                    ]
                  )
                ),
              ),
              SizedBox(
               height: 20, 
              ),

              InkWell(
                onTap: (){
                  Navigator.pushAndRemoveUntil(context, 
                        MaterialPageRoute(builder: (builder) =>LoginPage()),(route) => false);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width-110,
                  height: 50,
                
                  child: Card(
                    margin: EdgeInsets.all(0),
                    elevation: 8,
                    color: Colors.greenAccent[700],
                    child: Center(
                      child: Text("Agree and continue",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize:18
                      ), )),
                  ) ,
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}