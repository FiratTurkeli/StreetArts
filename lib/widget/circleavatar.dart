import 'package:flutter/material.dart';

class CirlceAvatar extends StatelessWidget {
  const CirlceAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          //CircleAvatar(
           // radius: 40,
           // backgroundImage: MemoryImage(_image!),
        //  ),
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage("images1/user.jpg"),
          ),

          Positioned(bottom: -10, left: 42,child: IconButton(onPressed:(){

          },
              icon: Icon(Icons.add_a_photo , color: Colors.black45,)))
        ],
      ),
    );
  }
}
