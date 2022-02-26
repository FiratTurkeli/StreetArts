import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:istanbulsokaksanatlari/ListDrawer.dart';
import 'package:istanbulsokaksanatlari/constant/textstyle.dart';
import 'package:istanbulsokaksanatlari/drawerpages/ArtistList.dart';
import 'package:istanbulsokaksanatlari/widget/appBars/header1.dart';





class MenuSayfa extends StatefulWidget {
  const MenuSayfa({Key? key}) : super(key: key);

  @override
  _MenuSayfaState createState() => _MenuSayfaState();
}

class _MenuSayfaState extends State<MenuSayfa> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  const ListDrawer(),
      backgroundColor: Colors.black,
      body: Builder(
        builder: (context) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images1/duvar3.webp"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
                )
            ),

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
                        child: buildCategoriesCard())

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
                                           context) => ArtistList(category_name: categoryList["category_name"],)));
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
