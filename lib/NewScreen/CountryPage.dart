import 'package:chatapp/Model/CountryModel.dart';
import 'package:chatapp/NewScreen/LoginPage.dart';
import 'package:flutter/material.dart';

class CountryPage extends StatefulWidget {
  const CountryPage({super.key, required this.setCountryData});
  final Function setCountryData;

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List<CountryModel> countries=[
    CountryModel(name: "Ethiopia", code: "+251", flag:"🇪🇹")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.teal,
            )
            ),
        title: Text("Choose a country",
        style: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.w600,
            fontSize:18,
            wordSpacing: 1,
            ),
            ),
            
           actions: [
           IconButton(onPressed: () {},  
            icon:Icon(Icons.search, color: Colors.teal,))
           ], 
            ),

            body: ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context,index) =>card(countries[index])),
    );
  }

  Widget card(CountryModel country) {
    return InkWell(
      onTap: (){
        widget.setCountryData(country);
      },
      child: Card(
        margin:EdgeInsets.all(0.15),
        child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal:20, vertical:5),
         child: Row(
           children: [
               Text(country.flag), 
               SizedBox(width: 15,),
               Text(country.name),
      
               Expanded(
                 child: Container(
                  width: 150,
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.end ,
                    children: [
                      Text(country.code),
                    ],
                  )),
               ),
           ],
         ),
        ),
      ),
    );
  }
}