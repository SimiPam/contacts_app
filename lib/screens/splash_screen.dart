import 'dart:async';

import 'package:contacts_app/screens/contacts_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => OnboardingScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      backgroundColor: Colors.teal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo here
            // Image.asset(
            //   'assets/images/goldie.jpg',
            //   height: 500,
            //   width: 500,
            // ),
            Text(
              "PhoneBook",
              style: GoogleFonts.monoton(
                  fontSize: 40,
                  // color: Theme.of(context).accentColor,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),

            SizedBox(
              height: 20,
            ),
            // SpinKitDoubleBounce(
            //   color: Theme.of(context).accentColor,
            //   size: 100,
            // ),
            CircularProgressIndicator(
              // backgroundColor: Theme.of(context).accentColor,
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
            ),
          ],
        ),
      ),
    );
  }
}
