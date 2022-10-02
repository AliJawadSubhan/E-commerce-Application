import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasetest/custom_widgets/products.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ProductStreams extends StatefulWidget {
  ProductStreams({super.key});

  @override
  State<ProductStreams> createState() => _ProductStreamsState();
}

class _ProductStreamsState extends State<ProductStreams> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> items =
      FirebaseFirestore.instance.collection('items').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: items,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.deepPurpleAccent,
          ));
        }

        return OrientationBuilder(builder: (context, orientation) {
          return GridView.builder(
              dragStartBehavior: DragStartBehavior.start,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 14),
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
                  childAspectRatio:
                      orientation == Orientation.portrait ? 0.77 : 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 5),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                QueryDocumentSnapshot data = snapshot.data!.docs[index];
                return Products(data: data);
              });
        });
      },
    );
  }
}
