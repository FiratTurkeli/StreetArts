import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:istanbulsokaksanatlari/constant/utils/image_picker_util.dart';
import 'package:istanbulsokaksanatlari/widget/textfields/textfieldbirthday.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:istanbulsokaksanatlari/widget/textfields/textfield.dart';

import '../constant/textstyle.dart';
import '../services/auth_methods.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _tcController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordAgainController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;



  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _birthdayController.dispose();

  }

  void selectImage()async{
   Uint8List im = await pickImage(ImageSource.gallery);
   setState(() {
     _image = im;
   });

  }

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
        surname: _surnameController.text,
      birthday: _birthdayController.text,

       );
    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginScreen()
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      showSnackBar(context, res);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images1/duvar3.webp"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken)
            )
        ),

        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Center(
            child: SingleChildScrollView(
              reverse: true,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Text("S A", style: GoogleFonts.permanentMarker(textStyle: ibbText)),
                    SizedBox(width: 160, child: Image.asset("images1/StreetArts2.png")), //200

                    TextFieldInput(
                        textEditingController: _nameController,
                        hintText: "Name",
                        textInputType: TextInputType.text,
                        icon: Icon(Icons.person, color: Colors.white, size: 24,)
                    ),
                    TextFieldInput(
                        textEditingController: _surnameController,
                        hintText: "Surname",
                        textInputType: TextInputType.text,
                        icon: Icon(Icons.person, color: Colors.white, size: 24,)
                    ),
                    TextFieldInput(
                        textEditingController: _emailController,
                        hintText: "Email",
                        textInputType: TextInputType.emailAddress,
                        icon: Icon(Icons.mail_outline_outlined, color: Colors.white, size: 24,)
                    ),
                    TextFieldInput(
                        textEditingController: _passwordController,
                        hintText: "Password",
                        textInputType: TextInputType.text,
                        icon: Icon(Icons.vpn_key_outlined, color: Colors.white, size: 24,),
                      isPass: true,
                    ),
                    TextFieldBirthday(
                        hintText: "Birthday",
                        icon: Icon(Icons.calendar_today_outlined, color: Colors.white, size: 24,),
                      textEditingController: _birthdayController,
                    ),
                    signUp1()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }




  Widget signUpButton(){
    return TextButton(onPressed: () async {
      String res = await AuthMethods().signUpUser(
          email: _emailController.text,
          password: _passwordController.text,
          name: _nameController.text,
          surname: _surnameController.text,
          birthday: _birthdayController.text

      );
      print(res);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    },
    child: _isLoading ? const Center(
      child: CircularProgressIndicator(color: Colors.white,),
    )
        : Text("REGİSTER" , style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,  color: Colors.white),));
  }


 Widget signUp1(){
    return InkWell(
        onTap: signUpUser,
        child: Text("REGİSTER", style: TextStyle(color: Colors.white),));
 }



}



