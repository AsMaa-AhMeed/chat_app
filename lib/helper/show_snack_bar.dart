import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String data, {Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: color ?? Colors.red, content: Text(data)));
}
