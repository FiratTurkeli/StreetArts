import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextFieldBirthday extends StatefulWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final Icon icon;



  const TextFieldBirthday({Key? key, required this.textEditingController, this.isPass = false, required this.hintText, required this.icon}) : super(key: key);

  @override
  State<TextFieldBirthday> createState() => _TextFieldBirthdayState();
}

class _TextFieldBirthdayState extends State<TextFieldBirthday> {

  bool ontap = false;
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
            keyboardType: TextInputType.none,
            onTap: () async {
            showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoActionSheet(
                  actions: [
                    showDatePicker()
                  ],
                  cancelButton: CupertinoActionSheetAction(
                    child: Text("Tamam"),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                )


            );

             },
            style: TextStyle(color: Colors.white),
            textInputAction: TextInputAction.done,
            controller: widget.textEditingController,
            obscureText: widget.isPass,
            cursorColor: Colors.white,
            decoration: InputDecoration(
                contentPadding:  const EdgeInsets.symmetric(vertical: 15,),
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: const TextStyle(color: Colors.white54),
                fillColor: Colors.white,
                focusColor: Colors.white,
                prefixIcon: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 15),
                    child: widget.icon
                )
            ),
          ),
        ),
      ),
    );
  }
  Widget showDatePicker()  {
      return SizedBox(
        height: 300,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          backgroundColor: Colors.white,
        initialDateTime: DateTime.now(),
        maximumYear: 2100,
        minimumYear: 1881,
        onDateTimeChanged: (DateTime pickedDate) {
          if(pickedDate != null ){
            print(pickedDate);
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            print(formattedDate);

            setState(() {
              widget.textEditingController.text = formattedDate;
            });

          }else{
            print("Date is not selected");
          }


        },

    ),
      );
  }

}