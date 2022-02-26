import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:istanbulsokaksanatlari/BottomPage.dart';
import 'package:istanbulsokaksanatlari/HomePage.dart';

class AppBarYellowBack extends StatelessWidget implements PreferredSizeWidget{

  Size get preferredSize => const Size.fromHeight(120);

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      toolbarHeight: 120,
      title: Image.asset("images1/StreetArts.png" , height: 100,),
      backgroundColor: Colors.lime,
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomPage()));
          }, icon: Icon(Icons.home, color: Colors.white, size: 35,),)
        )
      ],

    );
  }
}