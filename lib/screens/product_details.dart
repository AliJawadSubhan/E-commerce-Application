import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom_widgets/custom_button.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails({super.key, required this.data});

  final QueryDocumentSnapshot data;
  static String userId = FirebaseAuth.instance.currentUser!.uid;
  final db = FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('cart');

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.zero,
              height: size.height * 0.4,
              width: size.width,
              child: Image(
                image: NetworkImage(data.get('image')),
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.get('title'),
                    style: GoogleFonts.montserrat(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    ' Price \$: ${data.get('price')} ',
                    style: GoogleFonts.montserrat(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    loading: false,
                    text: 'Add to cart!',
                    func: () async {
                      var ha = await db.doc(data.id).get();
                      if (ha.exists != true) {
                        db.doc(data.id).set({
                          'image': data.get('image').toString(),
                          'title': data.get('title').toString(),
                          'price': data.get('price').toString()
                        }).then((value) {
                          final snackBar = SnackBar(
                            duration: const Duration(seconds: 1),
                            content: Text(
                                '${data.get('title')} is added to your cart.'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      }
                      print(ha.exists);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Description!",
                      style: GoogleFonts.montserrat(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      data.get('description'),
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
