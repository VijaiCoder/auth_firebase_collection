import 'package:auth_firebase_flutter/services/firebase_auth_method.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/text_field.dart';
import 'homeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUser() {
    context.read<FirebaseAuthMethods>().loginWithEmail(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            'Log in',
            style: TextStyle(
              color: Colors.black,
              fontSize: 40,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 300,
            child: CustomTextField(
              controller: emailController,
              text: 'Enter email',
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 300,
            child: CustomTextField(
              controller: passwordController,
              text: 'Enter Password',
            ),
          ),
          const SizedBox(height: 20),
          CustomButton(ontap: loginUser, text: 'Login')
        ]),
      ),
    );
  }
}
