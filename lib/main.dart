import 'package:firebase_core/firebase_core.dart';
import 'package:firebasetest/firebase_options.dart';
import 'package:firebasetest/main_pages.dart';
import 'package:firebasetest/login.dart';
import 'package:firebasetest/home_page.dart';
import 'package:flutter/material.dart';

// import 'dart:io';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
