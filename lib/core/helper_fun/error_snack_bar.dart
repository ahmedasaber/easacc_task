import 'package:flutter/material.dart';

void showErrorBar(
  BuildContext context,
  String message, {
  Color? backgroundColor,
  int durationInSec = 3,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: durationInSec),
    ),
  );
}
