import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/helpers/product_streams.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;

  signout() async {
    try {
      await auth.signOut();
      Navigator.pop(context);
    } catch (e) {
      return Center(child: Text('$e error'));
    }
  }

  CollectionReference db = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        title: const Text('Product Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              signout();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ProductStreams(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
        child: Icon(Icons.shopping_cart_outlined),
        backgroundColor: Colors.deepPurple,
      ),
      drawer: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: FutureBuilder<DocumentSnapshot>(
          future: db.doc(user!.uid).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Container(
                color: Colors.deepPurple[200],
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: const NetworkImage(
                                'https://media.giphy.com/media/Hicydpti7wG3vA8Zr4/giphy.gif'),
                            backgroundColor: Colors.cyan[50],
                            radius: 40,
                          ),
                          const SizedBox(height: 10),
                          Flexible(
                              child: Text(
                            data['usernam'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )),
                          const SizedBox(height: 5),
                          Flexible(
                              child: Text(
                            data['email'],
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                letterSpacing: 1),
                          ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        leading: const Icon(
                          Icons.home_rounded,
                          color: Colors.white,
                        ),
                        title: const Text(
                          'Home',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        leading: const Icon(
                          Icons.add_shopping_cart_rounded,
                          color: Colors.white,
                        ),
                        title: const Text(
                          'Cart',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/cart');
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        leading: const Icon(
                          Icons.logout_rounded,
                          color: Colors.white,
                        ),
                        title: const Text(
                          'Logout',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                        onTap: () {
                          signout();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
