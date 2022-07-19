import 'package:auth_firebase_flutter/screens/mainScreen.dart';
import 'package:auth_firebase_flutter/services/firebase_auth_method.dart';
import 'package:auth_firebase_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!user.isAnonymous && user.phoneNumber == null)
              Text(user.email!),
            const SizedBox(height: 20),
            if (!user.isAnonymous && user.phoneNumber == null)
              Text(user.providerData[0].providerId),
            const SizedBox(height: 20),
            if (user.phoneNumber != null) Text(user.phoneNumber!),
            Text(user.uid),
            if (!user.emailVerified && !user.isAnonymous)
              const SizedBox(height: 20),
            CustomButton(
                ontap: () {
                  context
                      .read<FirebaseAuthMethods>()
                      .sendEmailVerification(context);
                },
                text: 'Verify Email'),
            const SizedBox(height: 20),
            CustomButton(
                ontap: () {
                  context.read<FirebaseAuthMethods>().signOUT(context);
                },
                text: 'SIGNOUT'),
            const SizedBox(height: 20),
            CustomButton(
                ontap: () {
                  context.read<FirebaseAuthMethods>().deleteAccount(context);
                },
                text: 'delete')
          ],
        ),
      ),
    );
  }
}
