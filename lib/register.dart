import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var emailcontroller = TextEditingController();

  var passwordcontroller = TextEditingController();

  var usernamecontroller = TextEditingController();

  register() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailcontroller.text.trim(),
      password: passwordcontroller.text.trim(),
    );
    addUserDetail(
        email: emailcontroller.text.trim(),
        username: usernamecontroller.text.trim());
  }

  Future addUserDetail({required email, required username}) async {
    await FirebaseFirestore.instance.collection('users').add({
      'email': email,
      'username': username,
    });
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
                Icon(
                  Icons.phone_android,
                  size: 85,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  "Hello!",
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
                CustomTextfield(
                  text: "Username",
                  controller: usernamecontroller,
                  obscure: false,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 5,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      register();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) {
                            return HomePage();
                          }),
                        ),
                      );
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
                            'Register',
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
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "I'm a member? ",
                        style: TextStyle(
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
