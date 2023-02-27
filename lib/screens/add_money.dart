import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:concoin/utils/ApiBaseHelper.dart';
import 'package:concoin/utils/Razorpay.dart';
import 'package:concoin/utils/Session.dart';
import 'package:concoin/utils/colors.dart';
import 'package:concoin/utils/common.dart';
import 'package:concoin/utils/constant.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

import '../utils/widget.dart';

class AddMoney extends StatefulWidget {
  AddMoney();

  @override
  _AddMoneyState createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  TextEditingController controller = new TextEditingController();
  bool saveStatus = false;
  String userId = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState((){
      userId = App.localStorage.getString("userId").toString();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  MyColorName.appbarBg,
      appBar: AppBar(
        title: Text(
          "Add Money",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: getWidth(49)),
            child: Column(
              children: [
                boxHeight(50),
                Container(
                  width: getWidth(590),
                  child: TextFormField(
                    controller: controller,
                    style: TextStyle(color:MyColorName.colorTextFour ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],

                    decoration: InputDecoration(
                      fillColor: MyColorName.colorTextFour.withOpacity(0.3),
                      filled: false,
                      label: text("Enter Amount"),
                    ),
                  ),
                ),
                boxHeight(50),
                !saveStatus?
                ElevatedButton(
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
                      'Add Money',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  onPressed: () {
                    if (controller.text == "") {
                      setSnackbar("Please Enter Amount", context);
                      return;
                    }
                    setState(() {
                      saveStatus = true;
                    });
                    RazorPayHelper razorHelper = new RazorPayHelper(
                        controller.text.toString(),
                        context, (result) {
                      if (result == "error") {
                        setState(() {
                          saveStatus = false;
                        });
                      } else {
                        addWallet(result);
                      }
                    }, 1);
                    razorHelper.init();
                  },
                ):CircularProgressIndicator(),
                boxHeight(250),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  bool loading = true;
  bool loadingCart = false;
  int? currentIndex;



  bool walletStatus = false;
  addWallet(result) async {
    try {
      setState(() {
        saveStatus = true;
      });
      Map params = {
        "user_id": userId.toString(),
        //curUserId.toString(),
        "amount": controller.text.toString(),
        "transaction_type":"wallet",
        "payment_method":"razorpay",
    "txn_id":result.toString(),
        "type":"credit",
        "status": "success".toString(),
        "message": "transaction by user",
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl + "add_transaction"), params);
      setState(() {
        saveStatus = false;
      });
      if (!response['error']) {
        Navigator.pop(context,"yes");
        setSnackbar(response['message'], context);
      } else {
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        saveStatus = false;
      });
    }
  }
}
