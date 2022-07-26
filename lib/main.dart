import'package:auth_firebase_flutter/services/firebase_auth_method.dart';
import'package:firebase_auth/firebase_auth.dart';
import'package:firebase_core/firebase_core.dart';
import'package:flutter/material.dart';
import'package:provider/provider.dart';
import'screens/homeScreen.dart';
import'screens/mainScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        Provider<FirebaseAuthMethods>(create: (_)=>FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context)=>context.read<FirebaseAuthMethods>().authState, initialData: null)
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if(firebaseUser != null){
      return const HomeScreen();

    }else{return const MainScreen();

    }
  }
}
