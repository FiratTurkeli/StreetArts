import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:istanbulsokaksanatlari/constant/text_style.dart';
import 'package:flutter/material.dart';
import 'package:istanbulsokaksanatlari/constant/color.dart';

import '../../constant/utils/datetime_utils.dart';


class PastEventsCard extends StatelessWidget {

  const PastEventsCard({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left:8.0, right: 8.0, bottom: 8.0),
      child: Stream(),
    );
  }

  Widget buildImage(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        color: imgBG,
        width: 80,
        height: 100,
        child: Hero(
          tag: image,
          child: Image.network(
            image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildEventInfo(context, var date, String location_name, String artist_name) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(DateTimeUtils.getFullDate(date), style: monthStyle),

          Text(artist_name, style: titleStyle),

          Row(
            children: <Widget>[
              Icon(Icons.location_on, size: 16, color: Colors.amber),

              Text(location_name, style: subtitleStyle),
            ],
          ),
        ],
      ),
    );
  }

  Widget Stream(){
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("event").where("date" , isLessThan: DateTime.now()).snapshots(),
     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
       if (!snapshot.hasData) {
         return const CircularProgressIndicator(
           color: Colors.amber,
           strokeWidth: 5,
           backgroundColor: Colors.red,
         );
       } else {
         return SingleChildScrollView(
           child: SizedBox(
             height: 380,
             child: ListView.builder(
                 scrollDirection: Axis.vertical,
                 primary: true,
                 shrinkWrap: true,
                 itemCount: snapshot.data.docs.length,
                 itemBuilder: (contex, index) {
                   DocumentSnapshot pastList = snapshot.data.docs[index];

                   return Container(
                     margin: const EdgeInsets.only(bottom: 12),
                     child: InkWell(
                       onTap: (){},
                       child: Row(
                         children: <Widget>[
                           buildImage(pastList["artist_image"]),
                           buildEventInfo(context, pastList["date"].toDate(), "${pastList["location_name"].toString()}", "${pastList["artist_name"]} ${pastList["artist_surname"]}  "),
                         ],
                       ),
                     ),
                   );
                 }
             ),
           ),
         );
       }
     }
    );
    }
}
