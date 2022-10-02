import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/custom_widgets/custom_button.dart';
import 'package:firebasetest/custom_widgets/cart_item.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  static String userId = FirebaseAuth.instance.currentUser!.uid;

  Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final Stream<QuerySnapshot> cartStreams = FirebaseFirestore.instance
      .collection('users')
      .doc(Cart.userId)
      .collection('cart')
      .snapshots();

  FirebaseFirestore store = FirebaseFirestore.instance;

  pricefooter(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            height: 2,
            color: Colors.grey,
            thickness: 2,
          ),
          Padding(padding: EdgeInsets.all(8)),
          Text(
            "price: 3180\$. ",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: cartStreams,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.deepPurpleAccent,
                  ));
                }
                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(
                      top: 5, left: 5, right: 5, bottom: 100),
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              store
                                  .collection('users')
                                  .doc(Cart.userId)
                                  .collection('cart')
                                  .doc(document.reference.id)
                                  .delete();
                            });
                          },
                          child: CartItem(
                            data: data,
                            documentid: Cart.userId,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                );
              },
            ),
            pricefooter(context),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: CustomButton(loading: false, text: 'CheckOut'),
            ),
          ],
        ),
      ),
    );
  }
}
