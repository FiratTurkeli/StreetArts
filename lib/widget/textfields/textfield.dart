import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final Icon icon;

  const TextFieldInput({Key? key, required this.textEditingController, this.isPass = false, required this.hintText, required this.textInputType, required this.icon}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: 300,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[600]!.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20)
          ),
          child:  TextFormField(
            style: TextStyle(color: Colors.white),
            keyboardType: textInputType,
            textInputAction: TextInputAction.done,
            controller: textEditingController,
            obscureText: isPass,
            cursorColor: Colors.white,
            decoration: InputDecoration(
                contentPadding:  const EdgeInsets.symmetric(vertical: 15,),
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.white54),
                fillColor: Colors.white,
                focusColor: Colors.white,
                prefixIcon: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 15),
                  child: icon
                )
            ),
          ),
        ),
      ),
    );
  }
}
