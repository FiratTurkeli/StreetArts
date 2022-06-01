import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String event_uid;
  final DateTime date;
  final String artist_name;
  final String artist_description;
  final String category_name;
  final String artist_image;
  final String artist_uid;
  final String artist_surname;
  final String location;


  EventModel({
    required this.event_uid,
    required this.artist_name,
    required this.artist_image,
    required this.artist_surname,
    required this.artist_uid,
    required this.category_name,
    required this.date,
    required this.artist_description,
    required this.location
  });


  static EventModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return EventModel(
      event_uid: snapshot["event_uid"],
        artist_name: snapshot["artist_name"],
        artist_surname: snapshot[" artist_surname"],
        artist_image: snapshot["artist_image"],
        artist_uid: snapshot["artist_uid"],
        date: snapshot ["date"],
        category_name: snapshot ["category_name"],
        artist_description: snapshot ["artist_description"],
      location: snapshot["location"]

    );
  }

  Map<String, dynamic> toJson() => {
    "event_uid" : event_uid,
    "artist_name": artist_name,
    "artist_surname": artist_surname,
    "artist_image": artist_image,
    "artist_uid": artist_uid,
    "date": date,
    "category_name": category_name,
    "artist_description": artist_description,
    "location" : location
  };
}