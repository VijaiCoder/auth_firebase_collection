import 'package:auth_firebase_flutter/screens/phone_Screen.dart';
import 'package:auth_firebase_flutter/screens/signupScreen.dart';
import 'package:auth_firebase_flutter/services/firebase_auth_method.dart';
import 'package:auth_firebase_flutter/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CustomButton(
              ontap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignUpScreen())),
              text: 'SignUpScreen'),
          const SizedBox(height: 20),
          CustomButton(
              ontap: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen())),
              text: 'LoginScreen'),
          const SizedBox(height: 20),
          CustomButton(
              ontap: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const PhoneVerify())),
              text: 'phoneverify'),
          const SizedBox(height: 20),
          CustomButton(
              ontap: () {
                context.read<FirebaseAuthMethods>().signInWithGoogle(context);
              },
              text: 'Google Sign In'),
          const SizedBox(height: 20),
          CustomButton(
              ontap: () {
                context.read<FirebaseAuthMethods>().signInAnonymously(context);
              },
              text: 'Anonymously'),
        ]),
      ),
    );
  }
}
