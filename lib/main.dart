import 'package:concoin/homepage.dart';
import 'package:concoin/screens/introduction.dart';
import 'package:concoin/screens/login.dart';
import 'package:concoin/splash.dart';
import 'package:concoin/utils/common.dart';
import 'package:concoin/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import './screens/coin_flip_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // initScreen = prefs.getInt("initScreen");
  // await prefs.setInt("initScreen", 1);
  await App.init();
  //
  // if (App.localStorage.getString("userId") != null) {
  //   curUserId = App.localStorage.getString("userId").toString();
  //
  // } else {
  //
  // }
  runApp(MyApp());
}

//TOSS KA BOSS OLOR CODE ( Orange #ff8e09/ Light blue #004879- Dark Blue #00193b )
class MyApp extends StatelessWidget {

  @override  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Toss Ka Boss',
          theme: ThemeData(
            primarySwatch: Colors.orange,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: SplashScreen()
          // curUserId!=null?HomePage():initScreen == null || initScreen == 0 ? OnboardingScreen() : Login(),
        );
      }
    );
  }


}
