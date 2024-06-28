import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:diet_app/ui/root_page.dart';
import 'package:diet_app/ui/screens/signin_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FirebaseAuth.instance.currentUser == null
              ? const SignIn()
              : const RootPage()),
    );
  }
}
