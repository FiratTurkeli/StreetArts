
//google playe at

import 'package:flutter/material.dart';
import 'package:istanbulsokaksanatlari/screens/drawer/drawer_screen.dart';
import 'package:istanbulsokaksanatlari/constant/text_style.dart';
import 'package:istanbulsokaksanatlari/constant/utils/app_utils.dart';
import 'package:istanbulsokaksanatlari/models/fake_event_model.dart';
import 'package:istanbulsokaksanatlari/constant/ui_helper.dart';
import 'package:istanbulsokaksanatlari/widget/appBars/header1.dart';
import 'package:istanbulsokaksanatlari/widget/background.dart';
import 'package:istanbulsokaksanatlari/widget/cards/past_events_card.dart';

import '../widget/cards/upcoming_events_card.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  late ScrollController scrollController;
  late AnimationController controller;
  late AnimationController opacityController;
  late Animation<double> opacity;

  void etkinlikDetayGor(FakeEvent etkinlik){
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
      drawer: const DrawerScreen(),
      backgroundColor: Colors.white,
      body: Container(
        decoration:  background(),
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
          UpComingEventsCard(),
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
                 PastEventsCard()
          ],
        ),
      ),
    );
  }
}


