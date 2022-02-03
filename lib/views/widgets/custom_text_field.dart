import 'package:flutter/material.dart';
import 'package:tiktok_clone/contants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.labelText,
      required this.controller,
      required this.icon,
      this.isPassword = false})
      : super(key: key);

  final String labelText;
  final bool isPassword;
  final TextEditingController controller;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscuringCharacter: '*',
      cursorColor: primayColor,
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(
          icon,
          color: primayColor,
        ),
        labelStyle: TextStyle(fontSize: 20, color: primayColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: borderColor,
          ),
        ),
      ),
    );
  }
}
