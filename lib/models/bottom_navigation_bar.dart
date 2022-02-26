import 'package:flutter/material.dart';


class HomePageButtonNavigationBar extends StatelessWidget {
  final Function(int) onTap;
  final int currentIndex;
  const HomePageButtonNavigationBar({Key? key, required this.currentIndex, required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: currentIndex,
      selectedItemColor: Colors.green,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          label: "Keşfet",
          icon: Icon(Icons.explore),
        ),
        BottomNavigationBarItem(
          label: "Kategoriler",
          icon: Icon(Icons.filter_list_alt),
        ),
        BottomNavigationBarItem(
          label: "Noktalarımız",
          icon: Icon(Icons.location_on),
        ),

        BottomNavigationBarItem(
          label: "Search",
          icon: Icon(Icons.search_sharp),
        ),
      ],
    );
  }
}
