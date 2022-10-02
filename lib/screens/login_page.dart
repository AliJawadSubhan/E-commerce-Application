import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/screens/dashboard_page.dart';
import 'package:firebasetest/screens/register_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom_widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();

  userLogin() async {
    var email = emailcontroller.text;
    var password = passwordcontroller.text;
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Navigator.pushNamed(context, '/dashboard');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Hello again!
                const Icon(
                  Icons.phone_android,
                  size: 85,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  "Hello Again!",
                  style: GoogleFonts.bebasNeue(fontSize: 54),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  "Welcome back, dear!",
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
                // email textfield
                const SizedBox(
                  height: 30,
                ),

                CustomTextfield(
                  controller: emailcontroller,
                  text: 'Email',
                  obscure: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                // password textfield
                CustomTextfield(
                  controller: passwordcontroller,
                  obscure: true,
                  text: "Password",
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 5,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      userLogin();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 17.0, horizontal: 15),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Not yet a member? ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text(
                        " Register now.",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
