import 'dart:async';

import 'package:concoin/models/wallet_model.dart';
import 'package:concoin/screens/add_money.dart';
import 'package:concoin/screens/recent_transaction_list.dart';
import 'package:concoin/screens/withdraw_wallet.dart';
import 'package:concoin/utils/ApiBaseHelper.dart';
import 'package:concoin/utils/Razorpay.dart';
import 'package:concoin/utils/Session.dart';
import 'package:concoin/utils/colors.dart';
import 'package:concoin/utils/common.dart';
import 'package:concoin/utils/constant.dart';
import 'package:concoin/utils/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:sizer/sizer.dart';
class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  bool selected = false, enabled = false, edit1 = false;
  String deliveryLocation = "", name = "", email = "", mobile = "", image = "";
  String userId = '';
  @override
  void initState() {
    super.initState();
    userId = App.localStorage.getString("userId").toString();
    getSaved();
    getWallet();
    getWalletBalance();
  }

  bool saveStatus = true;
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  bool loading = true;
  String total = "0";
  List<WalletModel> walletList = [];
  getWallet() async {
    try {
      setState(() {
        walletList.clear();
        saveStatus = false;
      });
      Map params = {
        "user_id": userId.toString()
        //curUserId.toString(),
      };
      Map response =
      await apiBase.postAPICall(Uri.parse(baseUrl + "get_transaction"), params);
      setState(() {
        saveStatus = true;
      });
      if (!response['error']) {
        for (var v in response['data']) {
          setState(() {
            // total = response['balance'].toString();
            walletList.add(new WalletModel(
                v['id'].toString(), v['transaction_type'].toString(), v['user_id'].toString(), v['order_id'].toString(), v['type'].toString(), v['txn_id'].toString(), v['payu_txn_id'].toString(), v['amount'].toString(),
                v['status'].toString(), v['currency_code'].toString(), v['payer_email'].toString(), v['message'].toString(), v['transaction_date'].toString(), v['date_created'].toString(), v['total'].toString()));
           });
        }
      } else {
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        saveStatus = true;
      });
    }
  }
  getWalletBalance() async {
    try {
      setState(() {
        walletList.clear();
        saveStatus = false;
      });
      Map params = {
        "user_id": userId.toString()
        //curUserId.toString(),
      };
      Map response =
      await apiBase.postAPICall(Uri.parse(baseUrl + "get_profile"), params);
      setState(() {
        saveStatus = true;
      });
      if (!response['error']) {
        for (var v in response['balance']) {
          setState(() {
            total = response['balance'][0]['balance'].toString();
            // walletList.add(new WalletModel(
            //     v['id'].toString(), v['transaction_type'].toString(), v['user_id'].toString(), v['order_id'].toString(), v['type'].toString(), v['txn_id'].toString(), v['payu_txn_id'].toString(), v['amount'].toString(),
            //     v['status'].toString(), v['currency_code'].toString(), v['payer_email'].toString(), v['message'].toString(), v['transaction_date'].toString(), v['date_created'].toString(), v['total'].toString()));
          });
        }
      } else {
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        saveStatus = true;
      });
    }
  }
  // getWallet() async {
  //   try {
  //     setState(() {
  //       walletList.clear();
  //       saveStatus = false;
  //     });
  //     Map params = {
  //       "user_id": curUserId.toString(),
  //     };
  //     Map response =
  //     await apiBase.postAPICall(Uri.parse(baseUrl + "get_transaction"), params);
  //     setState(() {
  //       saveStatus = true;
  //     });
  //     if (!response['error']) {
  //       for (var v in response['data']) {
  //         setState(() {
  //           total = response['balance'].toString();
  //           walletList.add(new WalletModel(
  //               v['id'].toString(), v['transaction_type'].toString(), v['user_id'].toString(), v['order_id'].toString(), v['type'].toString(), v['txn_id'].toString(), v['payu_txn_id'].toString(), v['amount'].toString(),
  //               v['status'].toString(), v['currency_code'].toString(), v['payer_email'].toString(), v['message'].toString(), v['transaction_date'].toString(), v['date_created'].toString(), v['total'].toString()));
  //         });
  //       }
  //     } else {
  //       setSnackbar(response['message'], context);
  //     }
  //   } on TimeoutException catch (_) {
  //     setSnackbar("Something Went Wrong", context);
  //     setState(() {
  //       saveStatus = true;
  //     });
  //   }
  // }

  getSaved() async {
    await App.init();
    if (App.localStorage.getString("address") != null) {
      setState(() {
        deliveryLocation = App.localStorage.getString("address").toString();
      });
    }
    if (App.localStorage.getString("image") != null) {
      setState(() {
        image = App.localStorage.getString("image").toString();
      });
    }
    if (App.localStorage.getString("name") != null) {
      setState(() {
        name = App.localStorage.getString("name").toString();
      });
    }
    if (App.localStorage.getString("email") != null) {
      setState(() {
        email = App.localStorage.getString("email").toString();
      });
    }
    if (App.localStorage.getString("phone") != null) {
      setState(() {
        mobile = App.localStorage.getString("phone").toString();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:  MyColorName.appbarBg,
      appBar: AppBar(
        // centerTitle: true,
        title: Text(
          "My Wallet",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Image.asset(
                  "assets/coins.png",
                  width: 100,
                  height: 80,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(name!=null&&name!=""?name:"Hi Guest",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 20
                ),
                ),
              ),
              Text(" Total : ${total} Coins",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontSize: 20
              ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> WithdrawScreen()));
                  },
                  child: Image.asset(
                    "assets/withdrawal.png",
                    width:200,
                    height: 100,
                  ),
                ),
              ),

              InkWell(
                onTap: ()async{
                  setState(() {
                    enabled = true;
                  });
                  await Future.delayed(Duration(milliseconds: 300));
                  setState(() {
                    enabled = false;
                  });
                  var result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>AddMoney()));
                  if(result =="yes"){
                    getWallet();
                  }
                },
                child: ScaleAnimatedWidget.tween(
                  enabled: enabled,
                  duration: Duration(milliseconds: 300),
                  scaleDisabled: 1,
                  scaleEnabled: 0.9,
                  child: Container(
                    width:getWidth(320),
                    height: getHeight(100),
                    child: Image.asset(
                      "assets/deposit.png",
                      width:getWidth(320),
                      height: getHeight(100),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getHeight(25),
              ),
              // new
              text('Recent Transaction',fontSize: 12.sp,fontWeight: FontWeight.bold),
              SizedBox(
                height: getHeight(20),
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: getWidth(30)),
                  child: WalletTransaction(walletList,saveStatus)),
              boxHeight(20),
            ],
          ),
        ),
      ),
    );
  }
}