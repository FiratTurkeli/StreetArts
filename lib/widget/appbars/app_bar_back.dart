import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../screens/profilsheet/profile_sheet_screen.dart';

class appBarBack extends StatelessWidget implements PreferredSizeWidget{

  Size get preferredSize => const Size.fromHeight(120);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 18.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 120,
        child: Builder(
            builder: (context) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    heroTag: "back",
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.arrow_back, color: Colors.white, size: 35,),
                    backgroundColor: Colors.transparent,
                  ),
                  Image.asset("images1/StreetArts2.png" , width: 100, height: 120,),
                  FloatingActionButton(
                    heroTag: "profile",
                    onPressed: (){
                      showModalBottomSheet(

                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16),
                              )
                          ),
                          context: context,
                          isScrollControlled: true,
                          builder: (context){
                            return ProfileSheetScreen( uid: FirebaseAuth.instance.currentUser!.uid,);
                          }

                      );

                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.person, color: Colors.white,size: 35,),
                    backgroundColor: Colors.transparent,
                  ),
                ],
              );
            }
        ),
      ),
    );
  }
}
