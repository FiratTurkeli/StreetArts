import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:istanbulsokaksanatlari/drawerpages/ArtistList.dart';
import 'package:istanbulsokaksanatlari/drawerpages/EventCalender.dart';

import 'drawerpages/ArtistList.dart';


class ListDrawer extends StatelessWidget {
  const ListDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10))
      ),
      child: Container(
        color: Colors.white,
        child: ListView(
          children: [
            SizedBox(height: 150,
              child: DrawerHeader(
                  child: Image.asset("images1/StreetArts2.png", height: 60, width: 60),
                decoration: const BoxDecoration(
                  color: Colors.lime

                ),

              ),
            ),
            ListView(

              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                 const ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Artists"),
                  trailing: Icon(Icons.keyboard_arrow_down),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [

                      ListTile(
                        leading: const Icon(Icons.music_note , color: Colors.deepPurple,),
                        title: const Text("Music"),
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  ArtistList(category_name: "Müzik",)));
                        },
                      ),

                      ListTile(
                        leading: const Icon(Icons.format_paint_outlined, color: Colors.purple,),
                        title: const Text("Graffiti"),
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  ArtistList(category_name: "Graffiti",)));
                          },
                      ),

                      ListTile(
                        leading: const Icon(Icons.people_sharp, color: Colors.deepOrangeAccent,),
                        title: const Text("Dance"),
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  ArtistList(category_name: "Dans",)));
                        },
                      ),
                    ],
                  ),
                ),

                ListTile(
                  leading: const Icon(Icons.event, color: Colors.green,),
                  title: const Text("Event Calendar"),
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const EventCalender()));
                    },
                ),

                ListTile(
                  leading: const Icon(Icons.favorite, color: Colors.red,),
                  title: const Text("Favorite Artists"),
                  onTap:(){},
                ),

                ListTile(
                  leading: const Icon(Icons.perm_phone_msg_sharp, color: Colors.black,),
                  title: const Text("Contact Us"),
                  onTap:(){},
                ),

                Padding(
                  padding: const EdgeInsets.only(top:8.0, right: 45.0,left: 45  ),
                  child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    primary: Colors.green[700],
                    onPrimary: Colors.white,
                  ),
                      onPressed: (){},
                      child: Text("Switch to Artist Profile")),
                )
              ],
            )
          ]
        ),
      ),
    );
  }
}
