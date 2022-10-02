import 'package:firebase_core/firebase_core.dart';
import 'package:firebasetest/firebase_options.dart';
import 'package:firebasetest/screens/cart_page.dart';

import 'package:firebasetest/screens/login_page.dart';
import 'package:firebasetest/screens/dashboard_page.dart';
import 'package:firebasetest/screens/register_page.dart';
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
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/register': (context) => const Register(),
        '/dashboard': (context) => const Dashboard(),
        '/cart': (context) => Cart()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
