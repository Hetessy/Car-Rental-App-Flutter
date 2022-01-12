import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> buildSnackError(
    String error, context, size) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.black,
      content: SizedBox(
        height: error.length < 30
            ? size.height * 0.03
            : error.length * size.height * 0.0007,
        child: Center(
          child: Text(
            error,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
}
