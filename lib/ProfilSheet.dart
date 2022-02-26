import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:istanbulsokaksanatlari/LoginPage.dart';
import 'package:istanbulsokaksanatlari/profilsheetsayfalar/ProfilPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:istanbulsokaksanatlari/showEvents.dart';
import 'package:istanbulsokaksanatlari/utils/image_picker_util.dart';
import 'package:istanbulsokaksanatlari/models/user.dart' as model;



class ProfilSheet extends StatefulWidget {
  final String uid;
  const ProfilSheet({Key? key , required this.uid}) : super(key: key);

  @override
  _ProfilSheetState createState() => _ProfilSheetState();
}

class _ProfilSheetState extends State<ProfilSheet> {


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
                SizedBox(
                  width: 380,
                  height: 170,
                  child: Card(
                    color: Colors.lime,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
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
                              Text("Amount", style: TextStyle(color: Colors.white),),
                              Text("0,00" , style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.white),)
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
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
                                    primary: Colors.white,
                                    onPrimary: Colors.black54,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15)
                                    )

                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListView(
                  scrollDirection: Axis.vertical,
                  primary: false,
                  shrinkWrap: true,
                  children: [
                    ListTile(

                      leading: const Icon(Icons.person),
                      title: const Text("Profile"),
                      trailing: const Icon(Icons.arrow_right),
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilPage(uid: FirebaseAuth.instance.currentUser!.uid,)));
                      },
                    ),


                    ListTile(
                      leading: const Icon(Icons.account_balance_wallet_outlined),
                      title: const Text("Wallet"),

                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => showEvent()));
                      },
                    ),


                    ListTile(
                      leading: const Icon(Icons.card_giftcard_outlined),
                      title: const Text("Invite"),

                      onTap:(){

                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.question_answer),
                      title: const Text("FAQ"),

                      onTap:(){

                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text("Settings"),

                      onTap:(){

                      },
                    ),
                    ListTile(
                      leading:  const Icon(Icons.exit_to_app),
                      title: const Text("Logout"),
                      onTap:() async {
                        _auth.signOut();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPage()));

                        Scaffold.of(context).showSnackBar(const SnackBar(content:  Text("Başarıyla çıkış yapıldı"))
                        );



                      },
                    ),
                  ],
                )
              ],
            ),

          ],
        ),
      ),
    );
  }

}
