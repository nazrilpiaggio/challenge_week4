import 'dart:async';
import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _goToNavigateToHome();
  }

  _goToNavigateToHome() async {
    await Future.delayed(Duration(seconds: 4));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
          image: AssetImage('assets/cafe.jpg'),
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}