import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:istanbulsokaksanatlari/EventDetailPage.dart';
import 'package:istanbulsokaksanatlari/constant/color.dart';
import 'package:istanbulsokaksanatlari/constant/text_style.dart';
import 'package:istanbulsokaksanatlari/models/ui_helper.dart';

import '../utils/datetime_utils.dart';

class upComingEventsCard extends StatelessWidget {


  const upComingEventsCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return upcomingEventCard();
  }




  Widget upcomingEventCard(){
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("event").where("date" , isGreaterThanOrEqualTo: DateTime.now()).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          if (!snapshot.hasData) {
            return const CircularProgressIndicator(
              color: Colors.amber,
              strokeWidth: 5,
              backgroundColor: Colors.red,
            );
          }  else {
            return SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                primary: true,
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (contex,index){
                    DocumentSnapshot upcomingList = snapshot.data.docs[index];
                    var date = upcomingList["date"].toDate();
                    return  InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetailPage(etkinlik: "${upcomingList["event_uid"]}")));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        margin: const EdgeInsets.only(right: 12),
                        child: Column(
                          children: <Widget>[
                            Expanded(child:InkWell(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  color: imgBG,
                                  width: double.infinity,
                                  child: Hero(
                                    tag: "${upcomingList["event_uid"]}",
                                    child: Image.network(
                                       upcomingList["artist_image"],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            )
                      ),
                            UIHelper.verticalSpace(24),
                            Row(
                            children: <Widget>[

                              Container(
                                decoration: BoxDecoration(
                                  color: primaryLight,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      width: 40,
                                        height: 40,
                                        child: Column(
                                          children: [
                                            Text(DateTimeUtils.getMonth(date), style: monthStyle,),
                                            Text(DateTimeUtils.getDayOfMonth(date), style: titleStyle,)
                                          ],
                                        )),
                                  ]
                                ),
                              ),
                               UIHelper.horizontalSpace(8),
                               Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                   Text("${upcomingList["artist_name"]} ${upcomingList["artist_surname"]}", style: yaklasanEtkinlikStyle),
                                   UIHelper.verticalSpace(4),
                                    Row(
                                      children: <Widget>[
                                          Icon(Icons.location_on, size: 16, color: Colors.amber),
                                          UIHelper.horizontalSpace(4),
                                          Text(upcomingList["location_name"], style: TextStyle(color: Colors.white)),
                                       ],
                                      ),
                                     ],
                                   ),
                            ],
                               )
                            ],
                        ),
                      ),
                    );
                  }
                  ),
            );
          }
        }
        );
  }


}
