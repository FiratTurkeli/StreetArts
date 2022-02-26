import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String image;
  final String name;
  final String surname;
  final List followers;
  final List following;
  final String birthday;

  const User(
      {required this.name,
        required this.birthday,
        required this.uid,
        required this.image,
        required this.email,
        required this.surname,
        required this.followers,
        required this.following});

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      birthday: snapshot["birthday"],
      name: snapshot["name"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      image: snapshot["image"],
      surname: snapshot["surname"],
      followers: snapshot["followers"],
      following: snapshot["following"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "uid": uid,
    "email": email,
    "photoUrl": image,
    "surname": surname,
    "followers": followers,
    "following": following,
    "birthday" : birthday,
  };
}