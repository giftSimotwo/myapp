import 'package:flutter/material.dart';
import 'package:myapp/pages/home.dart';
import 'package:myapp/pages/login.dart';
import 'package:myapp/pages/notes.dart';
import 'package:myapp/pages/signup.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyBd16uQPZGFWoArRECbZKtvXOoBeK8EnYE", appId: "1:871310532243:web:2366a4027659bf4316f766", messagingSenderId: "871310532243", projectId: "notes-90d85"));

  runApp(MaterialApp(
    
    debugShowCheckedModeBanner: false,

    initialRoute: "/notes",
    routes: {
      "/": (context) => Home(),
      "/login": (context) => Login(),
      "/notes": (context) => Notes(),
      "/signup": (context) => Signup()
    },

  ));
}

