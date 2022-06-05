import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:istanbulsokaksanatlari/constant/color.dart';
import 'package:istanbulsokaksanatlari/screens/profilsheet/profile_screen.dart';
import '../../constant/utils/image_picker_util.dart';
import '../login_screen.dart';



class ProfileSheetScreen extends StatefulWidget {
  final String uid;
  const ProfileSheetScreen({Key? key , required this.uid}) : super(key: key);

  @override
  _ProfileSheetScreenState createState() => _ProfileSheetScreenState();
}

class _ProfileSheetScreenState extends State<ProfileSheetScreen> {


  CollectionReference users = FirebaseFirestore.instance.collection("users");
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
    return SizedBox(
      height: 500,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(16),
              children: [
                profileBox(),
                listView(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding profileCard(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              height:60,
              width: 130,
              child: Text("Hello ${userData['name']}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),)),
          Text("Wallet", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20,color: Colors.white),),
          Text("Amount", style: TextStyle(color: white),),
          Text("0,00" , style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.white),)
        ],
      ),
    );
  }

  Padding walletView(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset("images1/StreetArts2.png", height: 90, width: 130,),
          ElevatedButton(onPressed: (){

          }, child: const Text("Deposit"),
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(120,30),
                textStyle: const TextStyle(fontSize: 20),
                primary: white,
                onPrimary: black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                )

            ),
          )
        ],
      ),
    );
  }

  ListTile listTile(IconData icon, String title, VoidCallback onTap){
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap
    );
  }

  ListView listView(){
    return ListView(
      scrollDirection: Axis.vertical,
      primary: false,
      shrinkWrap: true,
      children: [

        listTile(
          Icons.person,
          "Profile",
              (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,)));
          },
        ),

        listTile(
          Icons.account_balance_wallet_outlined,
          "Wallet",
              (){},
        ),

        listTile(
            Icons.card_giftcard_outlined,
            "Invite",
                () { }
        ),

        listTile(
            Icons.question_answer,
            "FAQ",
                () { }
        ),

        listTile(
            Icons.settings,
            "Settings",
                () { }
        ),

        listTile(
          Icons.exit_to_app,
          "Logout",
              () async {
            _auth.signOut();
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));

            Scaffold.of(context).showSnackBar(const SnackBar(content:  Text("Başarıyla çıkış yapıldı"))
            );
          },
        )
      ],
    );
  }

  SizedBox profileBox(){
    return SizedBox(
      width: 380,
      height: 170,
      child: Card(
        color: Colors.lime,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            profileCard(),
            const Spacer(),
            walletView(),
          ],
        ),
      ),
    );
  }
}
