import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'constant/color.dart';
import 'models/ui_helper.dart';

class showEvent extends StatefulWidget {
  const showEvent({Key? key}) : super(key: key);

  @override
  _showEventState createState() => _showEventState();
}

class _showEventState extends State<showEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: InkWell(
          onTap: (){},
          child: buildArtists(),
        ),
      ),
    );
  }

  Widget buildArtists() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("event").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        } else {
          return SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  primary: false,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index){
                    DocumentSnapshot eventList = snapshot.data.docs[index];

                    return  SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      primary: false,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Text(eventList['date'].toDate().toString()),

                          ],
                        )
                      ),
                    );
                  }
              ),
            ),
          );
        }
      },
    );
  }
}
