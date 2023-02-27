import 'dart:async';
import 'dart:math' as math;
import 'package:concoin/utils/ApiBaseHelper.dart';
import 'package:concoin/utils/Session.dart';
import 'package:concoin/utils/common.dart';
import 'package:concoin/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';



import 'homepage.dart';

// import "package:flare_flutter/flare_actor.dart";
class OtpScreen extends StatefulWidget {
  String? otp ="",mobile="";


  OtpScreen({this.otp,this.mobile});
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
  AnimationController(vsync: this, duration: Duration(seconds: 2))
    ..repeat();
  String? currentText;
  bool status = false;
  bool selected = false, enabled = false, edit1 = false, loading = false;

  var textEditingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.otp.toString()!="null"){
    }else{
      widget.otp = "1234";
    }
  }
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff004879),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                width: w,
                height: h*.964,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: new Image.asset(
                      'assets/thumb.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                  Center(
                    child: Text("OTP ${widget.otp}",
                        style: TextStyle(color: (Colors.white), fontSize: 30.0)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Text("ENTER YOUR 4 DIGIT CODE ",
                          style: TextStyle(color: (Colors.orange), fontSize: 20.0)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child:
                    PinCodeTextField(
                      keyboardType: TextInputType.phone,
                      cursorColor: Colors.black,
                      //backgroundColor: Colors.white,
                      length: 4,
                      obscureText: false,
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 50,
                          inactiveFillColor: Colors.white,
                          inactiveColor: Colors.white,
                          activeColor: Colors.white,
                          selectedFillColor: Colors.white,
                          activeFillColor: Colors.white,
                          disabledColor: Colors.white,
                          errorBorderColor: Colors.white,
                          selectedColor: Colors.white

                      ),
                      animationDuration: Duration(milliseconds: 400),
                      enableActiveFill: true,
                      controller: textEditingController,
                      onCompleted: (v) {
                        print("Completed");
                      },
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                      appContext: context,
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        selected = true;
                      });
                      loginUser("verify_user");
                    },
                    child: Container(
                      child: Center(
                        child: Text.rich(
                          TextSpan(
                              text: 'Didn\'t Got Code?',
                              style: TextStyle(color: Color(0xffffffff)),
                              children: [
                                TextSpan(
                                  text: ' Resend',
                                  style: TextStyle(color: Color(0xffff8e09)),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                  ),
                  !selected?ElevatedButton(
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
                        'Submit',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    onPressed: () {
                      if(textEditingController.text.toString()==widget.otp.toString()){
                        setState(() {
                          selected = true;
                        });
                        checkOtp();
                      }else{
                        setSnackbar("Wrong Otp", context);
                      }
                    },
                  ):CircularProgressIndicator(color: Colors.white,),
                  SizedBox(
                    width: 80.0,
                    height: 95.0,
                  ),
                ],),
              ),
              Positioned(
                bottom: -h * .25,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (_, child) {
                    return Transform.rotate(
                      angle: _controller.value*2*math.pi,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/wheel.png',
                          width: 400.0,
                          height: 350.0,
                          alignment: FractionalOffset.center,
                        ),
                      ),
                    );
                  },
                  child: FlutterLogo(size: 200),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;

  checkOtp() async {
    await App.init();
    isNetwork = await isNetworkAvailable();
    if (isNetwork) {
      try {
        Map data = {
          "mobile": widget.mobile.toString(),
          "otp": textEditingController.text.trim().toString(),
          "fcm_id": fcmToken.toString(),
        };
        Map response = await apiBase.postAPICall(Uri.parse(baseUrl + "verify_otp"),data);
        print(response);
        bool status = true;
        String? msg = response['message'];
        if(response['error']!=null){
          if (!response['error']) {
            setState(() {
              selected = !selected;
            });
            var data = response['data'];
            // setSnackbar("Otp Verify Successfully", context);
            App.localStorage.setString("userId", data[0]['id'].toString());
            App.localStorage.setString("name", data[0]['username'].toString());
            App.localStorage.setString("email", data[0]['email'].toString());
            App.localStorage.setString("phone", data[0]['mobile'].toString());
            App.localStorage.setString("otp", data[0]['otp'].toString());
            App.localStorage.setString("token", data[0]['fcm_id'].toString());
            App.localStorage.setString("image", data[0]['profile'].toString());
            App.localStorage.setString("address", data[0]['address'].toString());
            App.localStorage.setString("refer", data[0]['referral_code'].toString());
            setState(() {
              curUserId = data[0]['id'].toString();
            });
          //  timer!.cancel();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);

          }else{
            setState(() {
              selected = !selected;
            });
            setSnackbar(response['message'].toString(), context);
          }

        } else {
          setState(() {
            selected = !selected;
          });
          setSnackbar(msg!, context);
        }
      } on TimeoutException catch (_) {
        setSnackbar("Something Went Wrong", context);
        setState(() {
          selected = !selected;
        });
      }
    } else {
      setSnackbar("No Internet Connection", context);
      setState(() {
        selected = !selected;
      });
    }
  }
  loginUser(String url) async {
    await App.init();
    isNetwork = await isNetworkAvailable();
    if (isNetwork) {
      try {
        Map data;
        data = {
          "mobile":  widget.mobile.toString().toString(),
          // "password": "12345678",
          "login": "1",
          "accesskey": "90336",
          "fcm_id": fcmToken.toString(),
        };
        Map response = await apiBase.postAPICall(Uri.parse(baseUrl + url),data);
        print(response);
        bool status = true;
        String msg = response['message'];
        setState(() {
          selected = false;
        });
        if(response['error']!=null){
          if (!response['error']) {
            setSnackbar("Resend Otp Successfully", context);
            setState(() {
              widget.otp = response['otp'].toString();

             // _start = 15;
            });
           // startTimer();
            //curUserId = response['user_id'].toString();

          }else{
            // setSnackbar("Resend Otp Successfully", context);
            setState(() {
              widget.otp = response['otp'].toString();

              // _start = 15;
            });
          }
        } else {
          setState(() {
            selected = false;
          });
          setSnackbar(msg.toString(), context);
        }
      } on TimeoutException catch (_) {
        setSnackbar("Something Went Wrong", context);
        setState(() {
          selected = false;
        });
      }
    } else {
      setSnackbar("No Internet Connection", context);
      setState(() {
        selected = false;
      });
    }
  }
}