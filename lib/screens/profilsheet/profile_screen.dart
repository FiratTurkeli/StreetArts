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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(

                      leading: const Icon(Icons.person ,),
                      title: const Text("Your Account", style: TextStyle(fontWeight: FontWeight.bold , ),),
                      subtitle: const Text("Your identity information, phone number , e-posta addres etc",),
                      trailing: const Icon(Icons.arrow_right,),
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AccountInfoScreen(uid: FirebaseAuth.instance.currentUser!.uid)));

                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: const Icon(Icons.vpn_key_outlined),
                      title: const Text("Reset Your Password", style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: const Text("Change your password whenever you want", ),
                      trailing: const Icon(Icons.arrow_right),
                      onTap:(){

                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: const Icon(Icons.arrow_back),
                      title: const Text("Go to Homepage", style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: const Text("Make sure you're done", ),
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigationScreen()));
                      },
                    ),
                  ),

                ],
              )

            ]
        ),


    );
  }
}
