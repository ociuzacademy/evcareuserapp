import 'package:ev_booking/main.dart';
import 'package:ev_booking/view/home.dart';
import 'package:ev_booking/view/intro_screen.dart';

import 'package:ev_booking/modules/login/login_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Splash Screen',style: TextStyle(fontSize: 17),
        ),
      )
    );
  }

  @override
  void initState() {
  // Ensuring the base class initState is called
  super.initState();
  _navigatetohome(); // Start navigation
}

_navigatetohome() async {
  await Future.delayed(const Duration(seconds: 2), () {});
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const IntroductionPage(),
    ),
  );
}

}