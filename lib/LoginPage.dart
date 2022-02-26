import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:istanbulsokaksanatlari/services/auth.dart';
import 'package:istanbulsokaksanatlari/utils/image_picker_util.dart';
import 'package:istanbulsokaksanatlari/widget/textfields/textfield.dart';
import 'BottomPage.dart';
import 'RegisterPage.dart';
import 'constant/textstyle.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();


  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  bool visible = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }


  void loginUser() async {
    setState(() {
      _isLoading =true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text,
        password: _passwordController.text
    );


    if (res == "success") {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomPage()));
    }  else {
      showSnackBar(context, res);
    }
    setState(() {
      _isLoading = false;
    });
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

                    SizedBox(width: 200, child: Image.asset("images1/StreetArts2.png")),

                  TextFieldInput(
                      textEditingController: _emailController,
                      hintText: "Email adress",
                      textInputType: TextInputType.emailAddress,
                      icon: Icon(Icons.mail_outlined, color: Colors.white, size:24),
                  ),

                    TextFieldInput(
                        textEditingController: _passwordController,
                        hintText: "Password",
                        textInputType: TextInputType.text,
                      isPass: true,
                      icon: Icon(Icons.vpn_key_outlined, color: Colors.white, size:24 ),
                    ),

                    girisButonu(),

                    kayitButonu(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }

  Widget girisButonu(){
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, ),
      child: MaterialButton(
        onPressed: loginUser,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3,),)
            : const Text("Login" , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        height: 40,
        minWidth: 140,
        color: Colors.lime,
        textColor: Colors.black54,


      ),
    );
  }

  Widget kayitButonu(){
    return  TextButton(onPressed:(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));

    },
        child: const Text("Create Account" , style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,  color: Colors.white),));
  }



}





