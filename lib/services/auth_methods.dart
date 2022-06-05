import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:istanbulsokaksanatlari/models/user_model.dart' as model;

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user details
  Future<model.User> getUserDetails() async {
    User? currentUser = _auth.currentUser;

    DocumentSnapshot snap = await _firestore.collection("users").doc(currentUser!.uid).get();

    return model.User.fromSnap(snap);
  }

  // Signing Up User

  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
    required String surname,
    required String birthday

  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          name.isNotEmpty ||
          surname.isNotEmpty || birthday.isNotEmpty) {


         // registering user in auth with email and password

          UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,

        );
          
          print(cred.user!.uid);




        // adding user in our database

          model.User user = model.User(
            name: name,
            uid: cred.user!.uid,
            email: email,
            surname: surname,
            birthday: birthday,
            followers: [],
            following: [],
            image: ""
          );

          await _firestore.collection("users").doc(cred.user!.uid).set(user.toJson());

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}