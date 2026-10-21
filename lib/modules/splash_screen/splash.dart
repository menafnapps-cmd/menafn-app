import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:menafn/modules/bottomnav/bottomnav.dart';
import 'package:page_transition/page_transition.dart';

class splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedSplashScreen(
            duration: 3000,
            splash: Image.asset(
              'images/menafn_logo.png',
              height: 31,
            ),
            nextScreen: bottomNav(),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.scale,
            backgroundColor: Color(0xff88db52)
        ),
    );
  }
}
