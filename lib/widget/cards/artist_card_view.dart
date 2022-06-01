import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:istanbulsokaksanatlari/constant/color.dart';
import 'package:istanbulsokaksanatlari/constant/ui_helper.dart';

class ArtistCardView extends StatefulWidget {

  final String category_name;


  ArtistCardView({required this.category_name});

  @override
  State<ArtistCardView> createState() => _ArtistCardViewState();
}

class _ArtistCardViewState extends State<ArtistCardView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      primary: true,
      child: InkWell(
        onTap: (){},
        child: buildArtists(),
      ),
    );
  }

  Widget buildArtists() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("artist").where("category_name" , isEqualTo: widget.category_name).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        } else {
          return SingleChildScrollView(
            primary: true,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 480,
              child: ListView.builder(
                  primary: true,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index){
                DocumentSnapshot artistList = snapshot.data.docs[index];

                return  SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  primary: true,
                  child: InkWell(
                    onTap: (){
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                            ClipRRect(
                             borderRadius: BorderRadius.circular(16),
                              child: Container(
                                color: imgBG,
                                width: 120,
                                height: 200,
                                child: Hero(
                                  tag: artistList["image"],
                                  child: Image.network(
                                    artistList["image"],
                                    fit: BoxFit.cover,
                                 ),
                                ),
                              ),
                          ),
                          UIHelper.horizontalSpace(12),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("${artistList["name"]} ${artistList["surname"]}", style: const TextStyle(color: Colors.lime , fontWeight: FontWeight.bold, fontSize: 18)),
                              UIHelper.verticalSpace(12),
                              Text("${artistList["category_name"]}", style: const TextStyle(color: Colors.white , fontWeight: FontWeight.bold)),
                              UIHelper.verticalSpace(12),
                              Row(
                                children: <Widget>[
                                  const Icon(Icons.play_arrow, size: 16, color: Colors.lime),

                                  SizedBox(
                                    width: 180,
                                    height: 120,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("${artistList["description"]}", style: const TextStyle(color: Colors.white),)
                                      ],
                                    ),

                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
                 ),
            ),
          );
        }
      },
    );
  }
}



