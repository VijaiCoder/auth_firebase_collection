// ignore_for_file: prefer_interpolation_to_compose_strings, use_build_context_synchronously, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/showOTPDialog.dart';
import '../utils/showSnackbar.dart';

class FirebaseAuthMethods {
  late final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);
  Future<void> signUpWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await sendEmailVerification(context);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  User get user => _auth.currentUser!;
  //State
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  //EMAIL Login
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // ignore: duplicate_ignore
      if (!_auth.currentUser!.emailVerified) {
        await sendEmailVerification(context);
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Enter verification sent!');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //GOOGLE SIGN IN
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

//phone SIGNIN
  Future<void> phoneSignIn({
    required BuildContext context,
    required final String phoneNumber,
  }) async {
    TextEditingController codeContoller = TextEditingController();
    await _auth.verifyPhoneNumber(
        phoneNumber: '+91' + phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          showSnackBar(context, e.message!);
        },
        codeSent: ((String verificationId, int? resendToken) async {
          showOTPDialog(
            codeContoller: codeContoller,
            context: context,
            onPressed: () async {
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: verificationId,
                  smsCode: codeContoller.text.trim());
              await _auth.signInWithCredential(credential);
              Navigator.of(context).pop();
            },
          );
        }),
        codeAutoRetrievalTimeout: (String verificationId) {
          
        });
  }

  //anonymous
  Future<void> signInAnonymously(BuildContext context) async {
    try {
      await _auth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

//SignOut
  Future<void> signOUT(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  ///delect account
  Future<void> deleteAccount(BuildContext context) async {
    try {
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }
}
