
//google playe at

import 'package:flutter/material.dart';
import 'package:istanbulsokaksanatlari/ListDrawer.dart';
import 'package:istanbulsokaksanatlari/constant/text_style.dart';
import 'package:istanbulsokaksanatlari/models/event_model.dart';
import 'package:istanbulsokaksanatlari/models/ui_helper.dart';
import 'package:istanbulsokaksanatlari/utils/app_utils.dart';
import 'package:istanbulsokaksanatlari/widget/appBars/header1.dart';
import 'package:istanbulsokaksanatlari/widget/pastEventsCard.dart';
import 'package:istanbulsokaksanatlari/widget/upcomingEventsCard.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  late ScrollController scrollController;
  late AnimationController controller;
  late AnimationController opacityController;
  late Animation<double> opacity;

  void etkinlikDetayGor(Event etkinlik){
    Navigator.of(context).push(PageRouteBuilder(

        pageBuilder: (BuildContext context, animation, __){
          return FadeTransition(
            opacity: animation,
            child: Center()
          );
        }
        )
    );
  }

  @override
  void initState() {
    scrollController = ScrollController();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))..forward();
    opacityController = AnimationController(vsync: this, duration: const Duration(microseconds: 1));
    opacity = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      curve: Curves.linear,
      parent: opacityController,
    ));
    scrollController.addListener(() {
      opacityController.value = offsetToOpacity(
          currentOffset: scrollController.offset, maxOffset: scrollController.position.maxScrollExtent / 2);
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    opacityController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const ListDrawer(),
      backgroundColor: Colors.white,
      body: Container(
        decoration:  const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images1/duvar3.webp"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
            )
        ),
        child: Stack(
          children: <Widget> [
            SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  const header1(),
                  UIHelper.verticalSpace(16),
                  buildUpComingEventList(),
                  UIHelper.verticalSpace(16),
                  buildPastEvents(),
                ],
              ),
            )
          ] ,
        ),
      ),

    );
  }



  Widget buildUpComingEventList() {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Upcoming Events", style: headerStyle.copyWith(color: Colors.white)),
          UIHelper.verticalSpace(16),
          upComingEventsCard(),
        ],
      ),
    );
  }



  Widget buildPastEvents() {
    return SingleChildScrollView(
      child: Container(
        height: 450,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Past Events" , style: headerStyle,),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(Icons.more_horiz),
                ),
              ],
            ),
                 pastEventsCard()
          ],
        ),
      ),
    );
  }
}


