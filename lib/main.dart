import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:istanbulsokaksanatlari/BottomPage.dart';
import 'package:istanbulsokaksanatlari/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:istanbulsokaksanatlari/providers/user_provider.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider(),),
      ],
      child: MaterialApp(
        title: 'IBB SOKAK SANATLARI',
        debugShowCheckedModeBanner: false,
        home:  StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context , snapshot){
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return const BottomPage();
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("${snapshot.error}"),
                  );
                }  
              }  
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,

                  ),
                );
              }
              return const LoginPage();
            }

        ),
      ),
    );
  }
}

