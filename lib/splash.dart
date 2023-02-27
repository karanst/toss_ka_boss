import 'package:concoin/homepage.dart';
import 'package:concoin/screens/introduction.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:concoin/utils/ApiBaseHelper.dart';
import 'package:concoin/utils/Session.dart';
import 'package:concoin/utils/common.dart';
import 'package:concoin/utils/constant.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../otp.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
  AnimationController(vsync: this, duration: Duration(seconds: 2))..repeat();
  TextEditingController mobileCon = new TextEditingController();
  bool status = false;
  bool selected = true, enabled = false, edit = false, loading = false;
  String? userId = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId = App.localStorage.getString("userId").toString();
    print("this is current user id ${userId.toString()}");
    Future.delayed(Duration(microseconds: 1000), (){
      if(userId == 'null' || userId == ''){
        Future.delayed(Duration(seconds: 2), (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> OnboardingScreen()));
        });
      }else{
        Future.delayed(Duration(seconds: 2), (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: w,
                  height: h * .964,
                  color: Color(0xff004879),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 15.0,
                        height: 45.0,
                      ),
                      Image.asset(
                        'assets/thumb.png',
                        scale: 3,
                      ),
                      SizedBox(
                        width: 300.0,
                        height: 50.0,
                      ),
                      Text(
                        'Welcome',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        width: 60.0,
                        height: 30.0,
                      ),

                      SizedBox(
                        width: 25.0,
                        height: 45.0,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  // bottom: -h * .25,
                  child: AnimatedBuilder(
                      animation: _controller,
                      builder: (_, child) {
                        return Transform.rotate(
                          angle: _controller.value * 2 * math.pi,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              'assets/wheel.png',
                              scale: 3,
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  // loginUser(String url) async {
  //   await App.init();
  //   isNetwork = await isNetworkAvailable();
  //   if (isNetwork) {
  //     try {
  //       Map data;
  //       data = {
  //         "mobile": mobileCon.text.trim().toString(),
  //         "fcm_id": fcmToken.toString(),
  //       };
  //       Map response = await apiBase.postAPICall(Uri.parse(baseUrl + url),data);
  //       print(response);
  //       bool status = true;
  //       String msg = response['message'];
  //       setState(() {
  //         loading = false;
  //       });
  //       if(response['error']!=null){
  //         if (!response['error']) {
  //           //   setSnackbar(msg.toString(), context);
  //           // curUserId = response['id'].toString();
  //           navigateScreen(context, OtpScreen(mobile: mobileCon.text, otp :response['otp'].toString(),));
  //
  //         }else{
  //           navigateScreen(context, OtpScreen(mobile:mobileCon.text,otp :response['otp'].toString(),));
  //           // setSnackbar(response['message'].toString(), context);
  //         }
  //       } else {
  //         setState(() {
  //           loading = false;
  //         });
  //         setSnackbar(msg.toString(), context);
  //       }
  //     } on TimeoutException catch (_) {
  //       setSnackbar("Something Went Wrong", context);
  //       setState(() {
  //         loading = false;
  //       });
  //     }
  //   } else {
  //     setSnackbar("No Internet Connection", context);
  //     setState(() {
  //       loading = false;
  //     });
  //   }
  // }
}
