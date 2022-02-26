import 'package:cloud_firestore/cloud_firestore.dart';

class Artist {
  final String name;
  final String description;
  final String category_uid;
  final String category_name;
  final String image;
  final String uid;
  final String surname;
  final List followers;
  final List following;
  final String email;

  Artist({
    required this.email,
    required this.following,
    required this.followers,
    required this.surname,
    required this.uid,
    required this.category_uid,
    required this.category_name,
    required this.image,
    required this.name,
    required this.description,
  });


  static Artist fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Artist(
      name: snapshot["name"],
      image: snapshot["image"],
      surname: snapshot["surname"],
      followers: snapshot["followers"],
      following: snapshot["following"],
      uid: snapshot ["uid"],
      category_name: snapshot ["category_name"],
      description: snapshot ["description"],
      email: snapshot ["email"],
      category_uid: snapshot ["category_uid"]
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "uid": uid,
    "email": email,
    "image": image,
    "surname": surname,
    "followers": followers,
    "following": following,
    "category_name": category_name,
    "category_uid": category_uid,
    "description" : description

  };
}
