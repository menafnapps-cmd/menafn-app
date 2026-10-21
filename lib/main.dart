import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:menafn/shared/DioHelper.dart';
import 'package:menafn/shared/bloc_observer.dart';
import 'modules/checkupdate/check_update_forandroid.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  MobileAds.instance.initialize();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      theme: ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xff88db52),
          backgroundColor: Colors.white,
          elevation: 20.0,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: const Color(0xff88db52),
            statusBarIconBrightness: Brightness.light,
          ),
          backgroundColor: const Color(0xff88db52),
          elevation: 0.0,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: Image.asset(
          'images/menafn_logo.png',
          height: 31,
        ),
        duration: 3000,
        nextScreen: update(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: const Color(0xff88db52),
      ),
    );
  }
}
