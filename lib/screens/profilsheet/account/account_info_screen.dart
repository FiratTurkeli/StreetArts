import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:istanbulsokaksanatlari/constant/text_style.dart';
import 'package:istanbulsokaksanatlari/constant/ui_helper.dart';
import 'package:istanbulsokaksanatlari/screens/profilsheet/account/edit_profile_screen.dart';
import 'package:istanbulsokaksanatlari/widget/appBars/app_bar_back_yellow.dart';

import '../../../constant/color.dart';
import '../../../constant/utils/image_picker_util.dart';

class AccountInfoScreen extends StatefulWidget {
  final String uid;
  const AccountInfoScreen({Key? key , required this.uid}) : super(key: key);

  @override
  _AccountInfoScreenState createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {


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
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          profilepic(),
          list(),
        ],
      ),
    );
  }



 Widget profilePic(){
     if (userData["image"] == null) {
      return CircleAvatar(
          radius: 33,
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage(userData["image"]) //AssetImage("images1/user.jpg")
      );
    }  else {
      return CircleAvatar(
          radius: 33,
          backgroundColor: Colors.grey,
          backgroundImage: AssetImage("images1/user.jpg") //AssetImage("images1/user.jpg")
      );
    }
 }


  Widget profilepic(){
    return  Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, top: 20.0 ),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: Colors.green[700],
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:  [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Hello ${userData['name']} ", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700 , color: Colors.white),),
                UIHelper.verticalSpace(8),
                InkWell(
                  onTap:  (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid)));
                  },
                  child: Container(
                    width: 150,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white
                    ),
                    child: const Center(child:  Text("Edit" , style: TextStyle(fontWeight: FontWeight.w500),)),
                  ),
                )
              ],
            ),
           // CircleAvatar(radius: 33, backgroundColor: Colors.grey, backgroundImage: AssetImage("images1/user.jpg"))
          ],

        ),
      ),
    );
  }


  Widget list(){
    return  Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView(
            itemExtent: 50,
            primary: false,
            shrinkWrap: true,
            children: [

              listTile(
                  Icons.person,
                  "${userData['name']} ${userData['surname']}"
              ),

              listTile(
                  Icons.email,
                  "${userData['email']}"
              ),

              listTile(
                  Icons.calendar_today_sharp,
                  "Birthday: ${userData['birthday']}"
              ),

              listTile(
                  Icons.security,
                  "Personal ID"
              )
            ],
          ),
        ),
      ],
    );
  }

  ListTile listTile (IconData icon, String text){
    return  ListTile(
      leading: Icon(icon , color: lime,),
      title: Text(text, style: accountInfoStyle,),
      onTap:(){},
    );
  }
}
