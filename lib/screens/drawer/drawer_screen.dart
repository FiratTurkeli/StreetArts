import 'package:flutter/material.dart';
import 'package:istanbulsokaksanatlari/constant/color.dart';
import 'package:istanbulsokaksanatlari/screens/drawer/calendar_screen.dart';
import 'artist_list_screen.dart';



class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10))
      ),
      child: Container(
        color: white,
        child: ListView(
          children: [
            SizedBox(
              height: 150,
              child: drawerHeader(),
            ),
            ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                listTileHeader(Icons.person, "Artists", Icons.keyboard_arrow_down),
                artistByCategories(context),
                listTile(
                    Icons.event,
                    Colors.green,
                    "Event Calendar",
                      (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CalendarScreen()));
                  },
                ),
                listTile(
                    Icons.favorite,
                    black,
                    "Favorite Artists",
                        () { }
                ),
                listTile(
                    Icons.perm_phone_msg_sharp,
                    black,
                    "Contact Us",
                        () { }
                ),
                switchToArtistButton(),
              ],
            )
          ]
        ),
      ),
    );
  }

  ListTile listTile(IconData  icon, Color color, String text, VoidCallback onTap){
    return  ListTile(
      leading: Icon(icon, color: color,),
      title: Text(text),
      onTap: onTap,
    );
  }

  ListTile listTileHeader(IconData  icon, String text, IconData trailingIcon){
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      trailing: Icon(trailingIcon),
    );
  }

  Padding switchToArtistButton(){
    return Padding(
      padding: const EdgeInsets.only(top:8.0, right: 45.0,left: 45  ),
      child: ElevatedButton(

          style: ElevatedButton.styleFrom(
            primary: Colors.green[700],
            onPrimary: Colors.white,
          ),
          onPressed: (){},
          child: Text("Switch to Artist Profile")),
    );
  }

  DrawerHeader drawerHeader(){
    return  DrawerHeader(
      child: Image.asset("images1/StreetArts2.png", height: 60, width: 60),
      decoration: const BoxDecoration(
          color: Colors.lime
      ),
    );
  }

  Padding artistByCategories(BuildContext context){
    return    Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          listTile(
            Icons.music_note,
            Colors.deepPurple,
            "Music",
                (){Navigator.push(context, MaterialPageRoute(builder: (context) =>  ArtistListScreen(category_name: "Müzik",)));},
          ),

          listTile(
            Icons.format_paint_outlined,
            Colors.purple,
            "Graffiti",
                (){Navigator.push(context, MaterialPageRoute(builder: (context) =>  ArtistListScreen(category_name: "Graffiti",)));},
          ),


          listTile(
            Icons.people_sharp,
            Colors.deepOrangeAccent,
            "Dance",
                (){Navigator.push(context, MaterialPageRoute(builder: (context) =>  ArtistListScreen(category_name: "Dans",)));},
          ),
        ],
      ),
    );
  }
}
