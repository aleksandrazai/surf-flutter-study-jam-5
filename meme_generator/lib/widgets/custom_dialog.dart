import 'package:flutter/material.dart';

class CustomDialog {
  static showCustomDialog(
      {required BuildContext context,
      required Widget content,
      required List<Widget> actions}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Загрузить картинку'),
          content: content,
          actions: actions,
        );
      },
    );
  }
}
