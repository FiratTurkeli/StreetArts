import 'package:flutter/material.dart';

BoxDecoration background(){
  return BoxDecoration(
      image: DecorationImage(
        image: AssetImage("images1/duvar3.webp"),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
      )
  );
}