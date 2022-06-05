
import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

import '../constant/color.dart';
import '../constant/text_style.dart';
import '../constant/utils/datetime_utils.dart';


class EventDetailScreen extends StatefulWidget {

  final String etkinlik;
  const EventDetailScreen({Key? key , required this.etkinlik}) : super(key: key);
  @override
  _EventDetailScreenState createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> with TickerProviderStateMixin {

  late AnimationController controller;
  late AnimationController bodyScrollAnimationController;
  late ScrollController scrollController;
  late Animation<double> scale;
  late Animation<double> appBarSlide;
  double headerImageSize = 0;
  bool isFavorite = false;
  @override
  void initState() {

    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    bodyScrollAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.offset >= headerImageSize / 2) {
          if (!bodyScrollAnimationController.isCompleted) bodyScrollAnimationController.forward();
        } else {
          if (bodyScrollAnimationController.isCompleted) bodyScrollAnimationController.reverse();
        }
      });

    appBarSlide = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      parent: bodyScrollAnimationController,
    ));

    scale = Tween(begin: 1.0, end: 0.5).animate(CurvedAnimation(
      curve: Curves.linear,
      parent: controller,
    ));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    bodyScrollAnimationController.dispose();
    super.dispose();
  }

  Completer<GoogleMapController> haritaKontrol = Completer();
  var baslangicKonum = const CameraPosition(target: LatLng(40.9903, 29.0205), zoom: 15);

  @override
  Widget build(BuildContext context) {
    headerImageSize = MediaQuery.of(context).size.height / 2.5;
    return ScaleTransition(
      scale: scale,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                controller: scrollController,
                child:Stream()
              ),

              AnimatedBuilder(
                animation: appBarSlide,
                builder: (context, snapshot) {
                  return Transform.translate(
                    offset: Offset(0.0, -1000 * (1 - appBarSlide.value)),
                    child: Material(
                      elevation: 2,
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget Stream(){
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("event").where("event_uid", isEqualTo: widget.etkinlik).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                primary: true,
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (contex, index) {
                  DocumentSnapshot eventList = snapshot.data.docs[index];

                  return  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      buildHeaderImage("${eventList["artist_image"]}", "${eventList["artist_name"]} ${eventList["artist_surname"]}"),
                      buildEventDetails("${eventList["artist_name"]}",  "${eventList["artist_surname"]}", eventList["date"].toDate(), "${eventList["artist_description"]}"),
                    ],
                  );
                }
            );
          }
        }
    );
  }

  Widget buildEventDetails(String artistName, String artistSurname, DateTime date, String descrption){
    return  Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildEventTitle("${artistName} ${artistSurname}"),

          buildEventDate(date),

          buildAboutEvent(descrption),

          googleMap(),
        ],
      ),
    );
  }

  Widget googleMap(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        child: SizedBox(
            height: 150,
            width: 380,
            child: GoogleMap(initialCameraPosition: baslangicKonum,)),
      ),
    );
  }

  Widget buildHeaderImage(String image, String name) {
    double maxHeight = MediaQuery.of(context).size.height;
    double minimumScale = 0.8;
    return GestureDetector(
      onVerticalDragUpdate: (detail) {
        controller.value += detail.primaryDelta! / maxHeight * 2;
      },
      onVerticalDragEnd: (detail) {
        if (scale.value > minimumScale) {
          controller.reverse();
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Stack(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: headerImageSize,
            child: Hero(
              tag: image,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          buildHeaderButton(name),
        ],
      ),
    );
  }

  Widget buildHeaderButton(String name) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
              margin: const EdgeInsets.all(0),
              child: InkWell(
                onTap: () {
                  if (bodyScrollAnimationController.isCompleted) bodyScrollAnimationController.reverse();
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color:  Colors.black,
                  ),
                ),
              ),
              color: Colors.white,
            ),
            Card(
              shape: const CircleBorder(),
              elevation: 0,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () => setState(() => isFavorite = !isFavorite),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.black),
                ),
              ),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEventTitle(String name) {
    return Text(
      name,
      style: headerStyle.copyWith(fontSize: 32),
    );
  }

  Widget buildEventDate(var date) {
    return Row(
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
              Text(DateTimeUtils.getMonth(date), style: monthStyle),
              Text(DateTimeUtils.getDayOfMonth(date), style: titleStyle),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(DateTimeUtils.getDayOfWeek(date), style: titleStyle),

              const Text("10:00 - 12:00 PM", style: subtitleStyle),
            ],
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.all(2),
          decoration: const ShapeDecoration(shape: StadiumBorder(), color: Colors.lime),
          child: Row(
            children: <Widget>[
              Text("Calendar Calendar", style: subtitleStyle.copyWith(color: Colors.black)),
              FloatingActionButton(
                backgroundColor: Colors.white,
                mini: true,
                onPressed: () {},
                child: const Icon(Icons.add, color: Colors.black,),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildAboutEvent(String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text("About", style: headerStyle),

        Text(description, style: subtitleStyle),

      ],
    );
  }



  Widget buildEventLocation() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        'assets/map.jpg',
        height: MediaQuery.of(context).size.height / 3,
        fit: BoxFit.cover,
      ),
    );
  }


}
