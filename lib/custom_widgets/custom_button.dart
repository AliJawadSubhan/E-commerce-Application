import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatefulWidget {
  const CustomButton(
      {Key? key, required this.loading, this.func, required this.text})
      : super(key: key);

  final bool loading;
  final func;
  final String text;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 3,
            spreadRadius: 2,
            offset: Offset(1, 3),
          ),
        ],
        color: Colors.deepPurpleAccent,
      ),
      child: MaterialButton(
        onPressed: widget.func,
        child: Text(
          widget.text,
          style: GoogleFonts.montserrat(
            fontSize: 19,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
