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

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 2))
        ..repeat();
  TextEditingController mobileCon = new TextEditingController();
  bool status = false;
  bool selected = true, enabled = false, edit = false, loading = false;


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
                        height: 20.0,
                      ),
                      Text(
                        'Log In',
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextField(
                          maxLength: 10,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.phone,
                          controller: mobileCon,
                          decoration: InputDecoration(
                            counterText: '',
                            prefixIcon: Icon(Icons.call),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.teal)),
                            hintText: 'Mobile Number',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 60.0,
                        height: 30.0,
                      ),
                      !loading?ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size.fromWidth(320),
                          textStyle: TextStyle(
                            color: Colors.orange,
                            textBaseline: TextBaseline.alphabetic,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 12, 15),
                          child: const Text(
                            'Next',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        onPressed: () {
                          if(validateMob(mobileCon.text, "Please Enter Mobile Number","Please Enter Valid Mobile Number")!=null){
                            setSnackbar(validateMob(mobileCon.text, "Please Enter Mobile Number","Please Enter Valid Mobile Number").toString(), context);
                            return;
                          }
                          setState(() {
                            loading = true;
                          });
                          loginUser("verify_user");
                         /* Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OtpScreen()),
                          );*/
                        },
                      ) :
                      CircularProgressIndicator(color: Colors.white,),
                      SizedBox(
                        width: 25.0,
                        height: 45.0,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -h * .25,
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
   loginUser(String url) async {
    await App.init();
    isNetwork = await isNetworkAvailable();
    if (isNetwork) {
      try {
        Map data;
        data = {
          "mobile": mobileCon.text.trim().toString(),
          "fcm_id": fcmToken.toString(),
        };
        Map response = await apiBase.postAPICall(Uri.parse(baseUrl + url),data);
        print(response);
        bool status = true;
        String msg = response['message'];
        setState(() {
          loading = false;
        });
        if(response['error']!=null){
          if (!response['error']) {
         //   setSnackbar(msg.toString(), context);
           // curUserId = response['id'].toString();
            navigateScreen(context, OtpScreen(mobile: mobileCon.text, otp :response['otp'].toString(),));

          }else{
            navigateScreen(context, OtpScreen(mobile:mobileCon.text,otp :response['otp'].toString(),));
           // setSnackbar(response['message'].toString(), context);
          }
        } else {
          setState(() {
            loading = false;
          });
          setSnackbar(msg.toString(), context);
        }
      } on TimeoutException catch (_) {
        setSnackbar("Something Went Wrong", context);
        setState(() {
          loading = false;
        });
      }
    } else {
      setSnackbar("No Internet Connection", context);
      setState(() {
        loading = false;
      });
    }
  }
}
