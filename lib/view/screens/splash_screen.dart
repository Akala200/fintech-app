import 'dart:async';

import 'package:flutter/material.dart';
import 'package:euzzit/utility/colorResources.dart';
import 'package:euzzit/utility/strings.dart';
import 'package:euzzit/utility/style.dart';
import 'package:euzzit/view/screens/pixallet_onboarding_screen.dart';
import 'package:gradient_text/gradient_text.dart';

class SplashScreenWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3), () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => euzzitOnBoardingScreen())));
    return Scaffold(
      backgroundColor: ColorResources.COLOR_BACKGROUND,
      body: Center(
        child:   Image.asset('assets/Icon/logo.png', width: 400, height: 400),
      ),
    );
  }
}
