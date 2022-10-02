import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';

class Products extends StatefulWidget {
  Products({super.key, required this.data});
  final QueryDocumentSnapshot data;
  static User user = FirebaseAuth.instance.currentUser!;

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final store = FirebaseFirestore.instance
      .collection('users')
      .doc(Products.user.uid)
      .collection('carts');

  Color openIconColor = Colors.black;

  bool checkColor = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        color: Colors.grey[200],
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(12),
                  child: GestureDetector(
                    child: Image(
                      image: NetworkImage(
                        widget.data.get('image'),
                      ),
                      // width: 50,
                      height: 100,
                      fit: BoxFit.fill,
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return ProductDetails(data: widget.data);
                      }));
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Marquee(
                  text:
                      '${widget.data.get('title')}  \$${widget.data.get('price')}',
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                  fadingEdgeEndFraction: 0.6,
                  blankSpace: 50.0,
                  velocity: 50.0,
                  pauseAfterRound: const Duration(seconds: 0),
                  // startPadding: 10.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {});
                      },
                      child: FaIcon(
                        FontAwesomeIcons.heart,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {},
                        child: const FaIcon(
                          FontAwesomeIcons.cartShopping,
                          color: Colors.black,
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
