import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartItem extends StatefulWidget {
  CartItem({super.key, required this.data, required this.documentid});
  Map data;
  String? documentid;
  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  FirebaseFirestore store = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 120,
          margin:
              const EdgeInsets.only(left: 14, bottom: 14, right: 14, top: 30),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 6,
                spreadRadius: 2,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: SizedBox(
                        height: double.infinity,
                        child: Image(
                          image: NetworkImage(
                            widget.data['image'],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8),
                          ),
                          Text(
                            "${widget.data['title']}",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8),
                          ),
                          Row(
                            children: [
                              Text(
                                "1",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8),
                          ),
                          Text(
                            "${widget.data['price']}\$",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 7,
          right: 0,
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.cancel_outlined),
          ),
        ),
      ],
    );
  }
}
