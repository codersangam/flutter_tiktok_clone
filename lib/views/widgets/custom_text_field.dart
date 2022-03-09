import 'package:flutter/material.dart';
import 'package:tiktok_clone/contants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.labelText,
      required this.controller,
      required this.icon,
      this.isPassword = false,
      this.passwordIcon,
      this.onTap})
      : super(key: key);

  final String labelText;
  final bool isPassword;
  final TextEditingController controller;
  final IconData icon;
  final IconData? passwordIcon;
  final VoidCallback? onTap;

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
        suffixIcon: InkWell(
          onTap: onTap,
          child: Icon(
            passwordIcon,
            color: primayColor,
          ),
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
