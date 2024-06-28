import 'package:flutter/material.dart';
import 'package:diet_app/constants.dart';

class CustomTextfield extends StatelessWidget {
  final IconData icon;
  final bool obscureText;
  final String hintText;
  final TextEditingController controller;
  const CustomTextfield(
      {Key? key,
      required this.icon,
      required this.obscureText,
      required this.hintText,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: TextField(
        obscureText: obscureText,
        style: TextStyle(
          color: Constants.blackColor,
        ),
        controller: controller,
        decoration: InputDecoration(
          // border: InputBorder.none,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Constants.blackColor.withOpacity(.3),
            ),
          ),
          prefixIcon: Icon(
            icon,
            color: Constants.blackColor.withOpacity(.3),
          ),
          hintText: hintText,
        ),
        cursorColor: Constants.blackColor.withOpacity(.5),
      ),
    );
  }
}
