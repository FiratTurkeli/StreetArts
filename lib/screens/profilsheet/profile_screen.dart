import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:istanbulsokaksanatlari/screens/profilsheet/account/account_info_screen.dart';
import 'package:istanbulsokaksanatlari/widget/appBars/app_bar_back_yellow.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../constant/utils/image_picker_util.dart';
import '../bottom_navigation_screen.dart';
class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key , required this.uid}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  bool isLoading = false;
  var userData ={};

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      userData  = userSnap.data()!;

    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarYellowBack(),
        body: ListView(
            children: [
              ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [

                  listTile(
                      Icons.person,
                      "Your Account",
                      "Your identity information, phone number , e-posta addres etc",
                          () {  Navigator.push(context, MaterialPageRoute(builder: (context) => AccountInfoScreen(uid: FirebaseAuth.instance.currentUser!.uid)));}),

                  listTile(
                    Icons.vpn_key_outlined,
                    "Reset Your Password",
                    "Change your password whenever you want",
                        (){},
                  ),


                  listTile(
                    Icons.arrow_back,
                    "Go to Homepage",
                    "Make sure you're done",
                        (){Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigationScreen()));},
                  ),
                ],
              )

            ]
        ),


    );
  }

  Padding listTile(IconData icon, String title,String subtitle, VoidCallback onTap){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold),),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }
}
