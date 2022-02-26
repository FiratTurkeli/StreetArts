import 'package:flutter/material.dart';

class TextFieldUpdate extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final Icon icon;

  const TextFieldUpdate({Key? key, required this.textEditingController, this.isPass = false, required this.hintText, required this.textInputType, required this.icon}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        width: 300,
        decoration: BoxDecoration(
            color: Colors.white,
        ),
        child:  TextFormField(
          style: TextStyle(color: Colors.black),
          keyboardType: textInputType,
          textInputAction: TextInputAction.done,
          controller: textEditingController,
          obscureText: isPass,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightGreen),
              borderRadius: BorderRadius.circular(15)
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(15)
            ),
              contentPadding:  const EdgeInsets.symmetric(vertical: 15,),
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.black38),
              fillColor: Colors.black,
              focusColor: Colors.black,
              prefixIcon: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 15),
                  child: icon
              )
          ),
        ),
      ),
    );
  }
}
