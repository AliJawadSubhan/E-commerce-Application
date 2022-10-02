import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasetest/screens/login_page.dart';
import 'package:flutter/material.dart';

import 'custom_textfield.dart';

class EditDialog extends StatelessWidget {
  EditDialog({Key? key, required this.data}) : super(key: key);

  final Map data;
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController desccontroller = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;
  void done() {
    db
        .collection('posts')
        .doc(data['id'])
        .update({'title': titlecontroller.text, 'desc': desccontroller.text})
        .then((value) => print('user updated ig'))
        .catchError((error) => print('the error : $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: Container(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: ListView(
                children: [
                  CustomTextfield(
                      text: 'Title',
                      controller: titlecontroller,
                      obscure: false),
                  CustomTextfield(
                      text: 'description',
                      controller: desccontroller,
                      obscure: false),
                  SizedBox(
                    width: 320.0,
                    child: TextButton(
                      onPressed: () {
                        done();
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.deepPurple),
                      ),
                    ),
                  )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
