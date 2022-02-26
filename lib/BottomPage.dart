import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:istanbulsokaksanatlari/HomePage.dart';
import 'package:istanbulsokaksanatlari/SearchPage.dart';
import 'package:istanbulsokaksanatlari/CategoryPage.dart';
import 'package:istanbulsokaksanatlari/PointsPage.dart';
import 'package:istanbulsokaksanatlari/ProfilSheet.dart';
import 'package:istanbulsokaksanatlari/models/bottom_navigation_bar.dart';
import 'package:istanbulsokaksanatlari/providers/user_provider.dart';
import 'package:provider/provider.dart';

class BottomPage extends StatefulWidget {
  const BottomPage({Key? key}) : super(key: key);

  @override
  _BottomPageState createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {

  var pageList =[const HomePage(), const MenuSayfa(), const PointsPage(), const AramaSayfa()];
  int currentIndex = 0;
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    addData();
  }


  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page){
  pageController.jumpToPage(page);
  }

  void onPageChanged(int page){
    setState(() {
      _page = page;
    });
  }



  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false)!;
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: [
          const HomePage(),
          const MenuSayfa(),
          const PointsPage(),
          const AramaSayfa(),
          ProfilSheet(uid:  FirebaseAuth.instance.currentUser!.uid)
        ],
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        onTap: navigationTapped,
        currentIndex: _page,
        backgroundColor: Colors.white,
        activeColor: Colors.green,
        inactiveColor: Colors.grey,
        iconSize: 24,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Categories",
            icon: Icon(Icons.filter_list_alt),
            backgroundColor: Colors.white
          ),
          BottomNavigationBarItem(
            label: "Locations",
            icon: Icon(Icons.location_on),
          ),

          BottomNavigationBarItem(
            label: "Search",
            icon: Icon(Icons.search_sharp),
          ),
        ],
      ),
    );
  }
}
