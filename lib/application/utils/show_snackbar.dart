import 'package:flutter/material.dart';

void ShowSnackBar(BuildContext context, String title, Color bgColor) {
  SnackBar snackBar = SnackBar(
    content: Text(title),
    backgroundColor: bgColor,
    behavior: SnackBarBehavior.floating,
    duration: Duration(milliseconds: 500),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
