import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  CustomTextfield({
    required this.text,
    required this.controller,
    required this.obscure,
    Key? key,
  }) : super(key: key);
  final String text;
  final controller;
  bool obscure;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 5,
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple),
              borderRadius: BorderRadius.circular(12),
            ),
            border: InputBorder.none,
            hintText: text,
            filled: true,
            fillColor: Colors.white),
      ),
    );
  }
}
