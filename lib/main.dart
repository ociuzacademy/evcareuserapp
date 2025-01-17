

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ev_booking/view/evcharging_station_list.dart';
import 'package:ev_booking/view/home_page.dart';
import 'package:ev_booking/view/intro_screen.dart';
import 'package:ev_booking/modules/login/pages/login_page.dart';
import 'package:ev_booking/modules/signup/pages/signup.dart';
import 'package:ev_booking/modules/vehicleRegistration/pages/vehicle_register.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
      AnimatedSplashScreen(
        splash: 
        Image.asset(
          'assets/logo/logo.jpg',
          height: 150, // Set the height
          width: 150,  // Set the width
          fit: BoxFit.cover, // Adjust how the image fits its container
         // color: Colors.green, // Apply a tint color with transparency
          alignment: Alignment.center, // Align the image within its container
        ),

        splashTransition: SplashTransition.scaleTransition,
            // Center(
            // child: Text(
            //   'Splash Screen',style: TextStyle(fontSize: 17),
              

            // ),
            // ), 
      nextScreen:  const IntroductionPage(),),
    );
  }
}


