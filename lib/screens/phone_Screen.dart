import 'package:auth_firebase_flutter/services/firebase_auth_method.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_button.dart';
import '../widgets/text_field.dart';
import 'homeScreen.dart';

class PhoneVerify extends StatefulWidget {
  const PhoneVerify({Key? key}) : super(key: key);

  @override
  State<PhoneVerify> createState() => _PhoneVerifyState();
}

class _PhoneVerifyState extends State<PhoneVerify> {
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void phoneSignIn() {
    context
        .read<FirebaseAuthMethods>()
        .phoneSignIn(context: context, phoneNumber: phoneController.text)
        ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            'PHONE SIGN',
            style: TextStyle(
              color: Colors.black,
              fontSize: 40,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 300,
            child: CustomTextField(
              controller: phoneController,
              text: 'Enter phone number',
            ),
          ),
          const SizedBox(height: 20),
          CustomButton(ontap: phoneSignIn, text: 'SendOTP')
        ]),
      ),
    );
  }
}
