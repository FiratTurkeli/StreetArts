import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class appBar extends StatelessWidget implements PreferredSizeWidget{
  late String title;

  appBar({required this.title});

  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      toolbarHeight: 80,
      title: Text("${title}", style: GoogleFonts.beVietnamPro(fontSize: 20, fontWeight: FontWeight.bold),),
      backgroundColor: Colors.lime,
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Image.asset("images1/ibblogo.png"),
        )
      ],

    );
  }
}
