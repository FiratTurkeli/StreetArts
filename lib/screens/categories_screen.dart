import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:istanbulsokaksanatlari/screens/drawer/drawer_screen.dart';
import 'package:istanbulsokaksanatlari/constant/textstyle.dart';
import 'package:istanbulsokaksanatlari/widget/appBars/header1.dart';
import 'package:istanbulsokaksanatlari/widget/background.dart';

import 'drawer/artist_list_screen.dart';





class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  const DrawerScreen(),
      backgroundColor: Colors.black,
      body: Builder(
        builder: (context) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: background(),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const header1(),
                    Container(
                        width: 300,
                        child: buildCategoriesCard()
                    )
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );

}




  Widget buildCategoriesCard(){
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("categories").snapshots(),
           builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
           if (!snapshot.hasData) {
             return const CircularProgressIndicator();
           } else {
             return ListView.builder(
                 primary: false,
                 scrollDirection: Axis.vertical,
                 shrinkWrap: true,
                 itemCount: snapshot.data.docs.length,
                 itemBuilder: (context, index) {
                   DocumentSnapshot categoryList = snapshot.data.docs[index];

                   return SizedBox(
                     width: 300,
                     height: 150,
                     child: Padding(
                       padding: const EdgeInsets.only(top: 4.0),
                       child: Card(
                         clipBehavior: Clip.antiAlias,
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(15)
                         ),
                         child: Stack(
                           alignment: Alignment.center,
                           children: [
                             Text(categoryList["category_name"], style: GoogleFonts.josefinSans(
                                 textStyle: ibbText),),
                             Ink.image(image: NetworkImage(categoryList["category_image"]),
                               colorFilter: ColorFilter.mode(
                                   Colors.grey.withOpacity(0.7),
                                   BlendMode.modulate),
                               child: InkWell(
                                 onTap: () {
                                   Navigator.push(context, MaterialPageRoute(
                                       builder: (
                                           context) => ArtistListScreen(category_name: categoryList["category_name"],)));
                                 },
                               ),
                               fit: BoxFit.cover,
                             ),

                           ],
                         ),
                       ),
                     ),

                   );

                 }
             );
           }
         }

    );
  }
}
