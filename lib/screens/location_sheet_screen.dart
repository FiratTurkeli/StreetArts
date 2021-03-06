import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:istanbulsokaksanatlari/constant/ui_helper.dart';
import '../constant/color.dart';
import '../constant/utils/datetime_utils.dart';

class LocationSheetScreen extends StatefulWidget {

  final String location_uid;
  const LocationSheetScreen({Key? key, required this.location_uid}) : super(key: key);

  @override
  _LocationSheetScreenState createState() => _LocationSheetScreenState();
}

class _LocationSheetScreenState extends State<LocationSheetScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildInfo(),
          buildSheet(),
        ],
      ),
    );
  }

  Widget buildInfo(){
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 15, bottom: 5),
      child: Text("Events" , style: TextStyle(fontSize:20 , fontWeight: FontWeight.bold),),
    );
  }


  Widget buildSheet(){
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("event").where("location_uid" , isEqualTo: "${widget.location_uid}").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child:  CircularProgressIndicator(
                color: Colors.amber,
                strokeWidth: 5,
                backgroundColor: Colors.red,
              ),
            );
          }  else {
            return Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  primary: true,
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (contex, index){
                    DocumentSnapshot eventList = snapshot.data.docs[index];
                    return Column(
                      children: [
                        buildList(eventList["date"].toDate(),
                            "${eventList["artist_name"]} ${eventList["artist_surname"]}",
                            eventList["artist_image"],
                            "${eventList["category_name"]}" ,
                            "${eventList["location_name"]}"),
                      ],
                    );
                  }


              ),
            );
          }
        }

    );
  }


  Widget buildList(var date, String name, String image, String category_name, String location_name ){
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(right: 15.0, left: 15.0 , bottom: 10, top: 10),
        decoration: BoxDecoration(
            color: Colors.lightGreen[700],
            borderRadius: BorderRadius.circular(25)
        ),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildDateAndLocName(date, location_name),
            buildCategoryNameAndName(category_name, name),
            buildImage(image),

          ],
        ),
      ),
    );
  }

  Widget buildDateAndLocName(DateTime date, String location_name){
    return  Padding(
      padding: const EdgeInsets.only(top:3.0, bottom: 3, left: 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildDateContainer(date),
          UIHelper.verticalSpace(8),
          buildLocationName(location_name),
        ],
      ),
    );
  }

  Widget buildDateContainer(var date){
    return Container(
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(50)
      ),
      height: 30,
      width: 130,
      child: Center(child: Text(DateTimeUtils.getFullDate(date), style: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.bold),)),
    );
  }

  Widget buildLocationName(String location_name){
    return  Row(
      children: [
        Icon(Icons.location_on_sharp, color: Colors.limeAccent,),
        Text(location_name, style: TextStyle(color: Colors.white , fontSize: 15,),),
      ],
    );
  }

  Widget buildCategoryNameAndName(String category_name, String name){
    return SizedBox(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(top:3.0, bottom: 3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ) ,
              height: 30,
              width: 80,
              child: Center(child: Text(category_name, style: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.bold),))
          ),
          UIHelper.verticalSpace(8),
          Text(name, style: TextStyle(color: Colors.white, fontSize: 16 , fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }

  Widget buildImage(String image){
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(
          image,
        ),
      ),
    );
  }
}
