// ignore_for_file: file_names

import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context,
  String text,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        height: 60,
        alignment: Alignment.bottomCenter,
        decoration: const BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );
}
