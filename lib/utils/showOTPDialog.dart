import 'package:auth_firebase_flutter/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showOTPDialog({
  required BuildContext context,
  required TextEditingController codeContoller,
  required VoidCallback onPressed,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Container(
      height: 200,
      child: AlertDialog(
        title: const Text('Enter OTP'),
        content: Center(
          child: Column(
            children: [
              CustomTextField(controller: codeContoller, text: 'Enter OTP')
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: onPressed,
            child:  const Text('Done'),
          )
        ],
      ),
    ),
  );
}
