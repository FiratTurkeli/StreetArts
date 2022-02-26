import 'dart:ffi';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:istanbulsokaksanatlari/profilsheetsayfalar/account/AccounInfo.dart';
import 'package:istanbulsokaksanatlari/utils/image_picker_util.dart';
import 'package:istanbulsokaksanatlari/widget/appBars/appBarYellowBack.dart';
import 'package:istanbulsokaksanatlari/widget/textfields/textfieldupdate.dart';

import '../../services/StorageMethods.dart';

class EditProfile extends StatefulWidget{
 final String uid;
 const EditProfile({Key? key, required this.uid}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  Uint8List? _image;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;



  void updateUser(){

    FirebaseFirestore.instance.collection("users").doc(widget.uid).update({
      "name" : _nameController.text, "surname" : _surnameController.text, "email" : _emailController.text,}
    );
      Navigator.push(context, MaterialPageRoute(builder: (context) => AccountInfo(uid: FirebaseAuth.instance.currentUser!.uid)));
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarYellowBack(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Column(
                children: [
                  avatarUpdate(),
                  TextFieldUpdate(
                      textEditingController: _nameController,
                      hintText: "Name",
                      textInputType: TextInputType.text,
                      icon: Icon(Icons.person, color: Colors.black54, size: 24,)),
                  TextFieldUpdate(
                      textEditingController: _surnameController,
                      hintText: "Surname",
                      textInputType: TextInputType.text,
                      icon: Icon(Icons.person, color: Colors.black54, size: 24,)
                  ),
                  TextFieldUpdate(
                      textEditingController: _emailController,
                      hintText: "Email",
                      textInputType: TextInputType.emailAddress,
                      icon: Icon(Icons.mail_outline_outlined, color: Colors.black54, size: 24,)
                  ),
                  updateButton()
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }

  Widget updateButton(){
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, ),
      child: InkWell(
        onTap: updateUser,
        child: SizedBox(
          height: 50,
          width: 150,
          child: Card(
            color: Colors.green[700],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _isLoading
                    ? const Center(child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3,),)
                    : Text("Update" , style: TextStyle(fontSize: 17 , fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget avatarUpdate(){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        height: 100,
        child: Stack(
        children: [
        _image != null
        ? CircleAvatar(
        radius: 64,
        backgroundImage: MemoryImage(_image!),
        backgroundColor: Colors.red,
        )
            : const CircleAvatar(
        radius: 64,
        backgroundImage: NetworkImage(
        'https://i.stack.imgur.com/l60Hf.png'),
        backgroundColor: Colors.red,
        ),
        Positioned(
        bottom: -10,
        left: 80,
        child: IconButton(
        onPressed:selectImage,
        icon: const Icon(Icons.add_a_photo),
        ),
        )
        ],
        ),
      ),
    );
  }
}
