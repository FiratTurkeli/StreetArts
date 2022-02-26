import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:istanbulsokaksanatlari/ListDrawer.dart';
import 'package:istanbulsokaksanatlari/constant/color.dart';
import 'package:istanbulsokaksanatlari/utils/datetime_utils.dart';
import 'package:istanbulsokaksanatlari/widget/appBars/header1.dart';

import 'constant/text_style.dart';

class AramaSayfa extends StatefulWidget {
  const AramaSayfa({Key? key}) : super(key: key);

  @override
  _AramaSayfaState createState() => _AramaSayfaState();
}

class _AramaSayfaState extends State<AramaSayfa> {

  late ScrollController scrollController;
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false ;


  @override
  void initState() {
    scrollController =ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      drawer: const ListDrawer(),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Flexible(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images1/duvar3.webp"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const header1(),
                      buildSearch(),
                      isShowUsers? body() :   Text("")
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearch() {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        controller: searchController,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
            hintText: "Search...",
            hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))
        ),
        onFieldSubmitted: (String _){
          setState(() {
            isShowUsers = true;
          });
        },
      ),
    );
  }


  Widget body(){
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection("event").where("artist_name" , isGreaterThanOrEqualTo: searchController.text).get(),
        builder: (context,snapshot){
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            color: Colors.transparent,
            child: ListView.builder(
              itemExtent: 60,
              scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: (snapshot.data! as dynamic).docs.length,
                itemBuilder: (context,index){
                  var date =(snapshot.data! as dynamic).docs[index]["date"].toDate();
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage((snapshot.data! as dynamic).docs[index]["artist_image"]),
                    ),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text((snapshot.data! as dynamic).docs[index]["artist_name"] , style: const TextStyle(color: Colors.white , fontWeight: FontWeight.bold, fontSize: 18),),
                            const Text(" "),
                            Text((snapshot.data! as dynamic).docs[index]["artist_surname"] , style: const TextStyle(color: Colors.white , fontWeight: FontWeight.bold, fontSize: 18),),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.location_on_sharp, color: Colors.amber, size: 12,),
                            Text((snapshot.data! as dynamic).docs[index]["location_name"] , style: const TextStyle(color: Colors.white , fontSize: 14),),
                          ],
                        )
                      ],
                    ),

                    trailing:  Container(
                      decoration: BoxDecoration(
                        color: primaryLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
                      child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Column(
                            children: [
                              Text(DateTimeUtils.getMonth(date), style: monthStyle,),
                              Text(DateTimeUtils.getDayOfMonth(date), style: titleStyle,)
                            ],
                          )),
                    ),

                  );
                }
            ),
          );
        }
    );
  }



}
