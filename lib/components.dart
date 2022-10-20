import 'package:flutter/material.dart';

class Field extends StatelessWidget {
Field({
  required this.text,
  required this.myIcon,
  required this.secondIcon,
  required this.pass,
  required this.myFunction,
  required this.validator,
});
final String text;
final Icon myIcon;
final IconButton secondIcon;
bool pass;

void Function(String) myFunction;
String? Function(String?) validator;
@override
Widget build(BuildContext context) {
  return Material(
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical:10),
      child: TextFormField(
        onChanged: myFunction,
        textAlign: TextAlign.right,
        obscureText: pass,
        validator: validator,
        decoration: InputDecoration(
          hintText: text,
          suffixIcon: myIcon,
          prefixIcon: secondIcon,
          contentPadding:
          EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          filled: true,
          fillColor: Color(0XFFF0F0F0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(1.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: Colors.transparent, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: Colors.lightBlueAccent, width: 2.0),
          ),
        ),
      ),
    ),
  );
}
}
