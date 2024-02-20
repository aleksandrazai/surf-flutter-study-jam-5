import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.textEditingController,
    required this.fontSize,
    required this.hintText,
  });

  final TextEditingController textEditingController;
  final double fontSize;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      textAlign: TextAlign.center,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: Colors.black,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'Impact',
            fontSize: fontSize,
            color: Colors.white,
          )),
      style: TextStyle(
        fontFamily: 'Impact',
        fontSize: fontSize,
        color: Colors.white,
      ),
    );
  }
}
