import 'package:cloud_firestore/cloud_firestore.dart';

class Categories{
  final String category_uid;
  final String category_name;
  final String category_image;

  Categories({required this.category_uid, required this.category_name , required this.category_image});

  static Categories fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Categories(
      category_uid: snapshot["category_uid"],
      category_name: snapshot["category_name"],
      category_image: snapshot["category_image"]

    );
  }

  Map<String, dynamic> toJson() => {
    "category_name": category_name,
    "category_uid": category_name,
    "category_image" : category_image
    };
}