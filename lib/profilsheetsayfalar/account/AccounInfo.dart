import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:istanbulsokaksanatlari/models/ui_helper.dart';
import 'package:istanbulsokaksanatlari/profilsheetsayfalar/account/EditProfile.dart';
import 'package:istanbulsokaksanatlari/utils/image_picker_util.dart';
import 'package:istanbulsokaksanatlari/widget/appBars/appBarYellowBack.dart';

class AccountInfo extends StatefulWidget {
  final String uid;
  const AccountInfo({Key? key , required this.uid}) : super(key: key);

  @override
  _AccountInfoState createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {


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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(uid: FirebaseAuth.instance.currentUser!.uid)));
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
              ListTile(
                leading: const Icon(Icons.person, color: Colors.lime,),
                title:  Text("${userData['name']} ${userData['surname']}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                onTap:(){

                },
              ),


              ListTile(
                leading: const Icon(Icons.email, color: Colors.lime,),
                title: Text("${userData['email']}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),

                onTap:(){

                },
              ),




              ListTile(
                leading: const Icon(Icons.calendar_today_sharp , color: Colors.lime,),
                title:  Text("Birthday: ${userData['birthday']}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),


                onTap:(){

                },
              ),

              ListTile(
                leading: const Icon(Icons.security , color: Colors.lime,),
                title: const Text("Personal ID", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                onTap:(){

                },
              ),





            ],
          ),
        ),



      ],
    );
  }



}
