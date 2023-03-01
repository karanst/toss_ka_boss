import 'dart:async';

import 'package:concoin/main.dart';
import 'package:concoin/models/tournament_model.dart';
import 'package:concoin/privacy.dart';
import 'package:concoin/profile.dart';
import 'package:concoin/rate_us.dart';
import 'package:concoin/screens/coin_flip_screen.dart';
import 'package:concoin/screens/gaming_history.dart';
import 'package:concoin/screens/login.dart';
import 'package:concoin/terms.dart';
import 'package:concoin/utils/ApiBaseHelper.dart';
import 'package:concoin/utils/Session.dart';
import 'package:concoin/utils/colors.dart';
import 'package:concoin/utils/common.dart';
import 'package:concoin/utils/constant.dart';
import 'package:concoin/utils/widget.dart';
import 'package:concoin/wallet.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'about_us.dart';
import 'help.dart';


class HomePage extends StatefulWidget {


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const appTitle = 'Drawer Demo';
  String deliveryLocation = "", name = "", email = "", mobile = "", image = "";
  @override
  void initState() {
    super.initState();
    setState((){
      userId = App.localStorage.getString("userId").toString();
    });
    callApi();
    print("this is account balances ${total.toString()} aand  ${minBalance.toString()}");
  }
  String total = "0";
  String minBalance = '0';
  bool saveStatus = true;
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  String userId = '';

  getWallet() async {
    try {

      Map params = {
        "user_id": userId.toString()
        //curUserId.toString(),
      };
      Map response =
      await apiBase.postAPICall(Uri.parse(baseUrl + "get_transaction"), params);
      if (!response['error']) {
        setState(() {
          total = response['balance'].toString();
        });
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
        // walletList.clear();
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
  getMinBalance() async {
    try {
      setState(() {
        // walletList.clear();
        saveStatus = false;
      });
      Map params = {
        // "user_id": curUserId.toString(),
      };
      Map response =
      await apiBase.postAPICall(Uri.parse(baseUrl + "get_minimum_balance"), params);
      setState(() {
        saveStatus = true;
      });
      if (!response['error']) {
        // for (var v in response['balance']) {
          setState(() {
            minBalance = response['balance'].toString();
            // walletList.add(new WalletModel(
            //     v['id'].toString(), v['transaction_type'].toString(), v['user_id'].toString(), v['order_id'].toString(), v['type'].toString(), v['txn_id'].toString(), v['payu_txn_id'].toString(), v['amount'].toString(),
            //     v['status'].toString(), v['currency_code'].toString(), v['payer_email'].toString(), v['message'].toString(), v['transaction_date'].toString(), v['date_created'].toString(), v['total'].toString()));
          });
          print("this is minimum balance from api ${minBalance.toString()}");
        // }
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

  List<TournamentModel> tourList = [];
  String endTme = '';
  String checkId = "";
  bool join = false;

  getTournament() async {
    tourList.clear();
    try {
      setState(() {
        saveStatus = false;
      });
      Map params = {
        "user_id": userId.toString()
        //curUserId.toString(),
      };
      var response =
      await apiBase.postAPICall(Uri.parse(baseUrl + "game_list"), params);
      setState
        (() {
        saveStatus = true;
      });
      if(response['status']){
        // setState(() {
        //   tourList = response['data'];
        // });
        for (var v in response['data']) {
          setState(() {
            tourList.add(TournamentModel.fromJson(v));
          });
        }
        // for(var i = 0; i < tourList.length; i++){
        //   setState((){
        //     endTme =  DateFormat.jms().format(DateTime.parse(tourList[i].endTime.toString()));
        //   });
        //
        // }
      }else{
        setSnackbar(response['msg'], context);
      }

    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        saveStatus = true;
      });
    }
  }

  joinTournament() async {
    try {
      setState(() {
        join = true;
      });
      Map params = {
        "user_id": userId.toString(),
        //curUserId.toString(),
        "game_id": checkId.toString(),
      };
      var response =
      await apiBase.postAPICall(Uri.parse(baseUrl + "join_contest"),params);
      setState(() {
        join = false;
      });
      Fluttertoast.showToast(msg: response['msg']);
      // setSnackbar(response['msg'], context);
      if(response['status']){

      }else{

      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        saveStatus = true;
      });
    }
  }

    enterGame(String price, gameId, int endingTime, index) async {
    try {
      setState(() {
        join = true;
      });
      Map params = {
        "user_id": userId.toString(),
        //curUserId.toString(),
        "game_id": gameId.toString(),
        "amount" : price.toString()
      };
      var response =
      await apiBase.postAPICall(Uri.parse(baseUrl + "enter_game_user"),params);
      setState(() {
        join = false;
      });
      Fluttertoast.showToast(msg: response['message']);
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CoinFlipScreen(
            endTime: endingTime,
            amount: tourList[index].entryFee.toString(),
            gameId: tourList[index].id.toString(),
            time: tourList[index].endDateTime.toString()
            //DateFormat.jms().format(DateTime.parse(tourList[index].endDateTime.toString())),
          )));
      // setSnackbar(response['msg'], context);
      // if(response['status']){
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => CoinFlipScreen(
      //         endTime: endingTime,
      //         gameId: tourList[index].id.toString(),
      //       )));
      //
      // }else{
      //
      // }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        saveStatus = true;
      });
    }
  }

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
    print(name);
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
  Future _refresh() async {
    return callApi();
  }

  Future<Null> callApi() async {
    await getSaved();
    await getWallet();
    await getWalletBalance();
    await getMinBalance();
    await getTournament();
    await getSaved();
    return null;
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        color: MyColorName.appbarBg,
    key: _refreshIndicatorKey,
    onRefresh: _refresh,
    child:

      SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Toss Ka Boss',style: TextStyle(
            color: Colors.white,
          ),),
          iconTheme: IconThemeData(
            color: Colors.white
          ),
          backgroundColor: Color(0xff004879),
          actions: [IconButton(onPressed: (){
            _refresh();
          }, icon: Icon(Icons.refresh))],
        ),
        drawer: Drawer(
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        DrawerHeader(
                            decoration: BoxDecoration(
                              color: Color(0xff004879),
                            ),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    // ClipRRect(
                                    //   borderRadius: BorderRadius.circular(30),
                                    //   child: commonImage(image, getHeight(100),  getHeight(100), "assets/tails.png", context, "assets/tails.png"),
                                    // ),
                                    // SizedBox(
                                    //   width: 20,
                                    // ),
                                    Text(name!=null&&name!=""?"Hi, $name":"Hi Guest",textAlign: TextAlign.end,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => const Profile()),
                                          );
                                        },
                                        child:  image!= null && image!= "" ?
                                            Image.network(image.toString(),
                                              width: 60,
                                              height: 50,)
                                       : Image(image:
                                         AssetImage('assets/profile.png'),
                                          width: 60,
                                          height: 50,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    TextButton(
                                      onPressed: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>  Profile()),
                                        );
                                      },
                                      child: Text('Profile',style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                      ),

                                      ),),
                                  ],
                                ),

                              ],
                            )
                        ),
                        Container(
                          child: ListTile(
                            dense: true,
                            leading: const Icon(Icons.wallet_giftcard,color: Colors.black,),
                            title: const Text('Wallet',style: TextStyle(color: Colors.black),),
                            onTap: () {

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  Wallet()),
                              );
                            },
                          ),
                        ),
                        Divider(
                          height: 10,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        Container(
                          child: ListTile(
                            dense: true,
                            leading: const Icon(Icons.history_outlined,color: Colors.black,),
                            title: const Text('Gaming History',style: TextStyle(color: Colors.black),),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  GamingHistory()),
                              );
                            },
                          ),
                        ),
                        Divider(
                          height: 10,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        Container(
                          child: ListTile(
                            dense: true,
                            leading: const Icon(Icons.help,color: Colors.black,),
                            title: const Text('Help',style: TextStyle(color: Colors.black),),
                            onTap: () {

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  Help()),
                              );
                            },
                          ),
                        ),
                        Divider(
                          height: 10,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        Container(
                          child: ListTile(
                            dense: true,
                            leading: const Icon(Icons.rule_folder,color: Colors.black,),
                            title: const Text('Terms & Conditions',style: TextStyle(color: Colors.black),),
                            onTap: () {

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  Terms()),
                              );
                            },
                          ),
                        ),
                        Divider(
                          height: 10,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        Container(
                          child: ListTile(
                            dense: true,
                            leading: const Icon(Icons.privacy_tip_outlined,color: Colors.black,),
                            title: const Text('Privacy Policy',style: TextStyle(color: Colors.black),),
                            onTap: () {

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  Privacy()),
                              );
                            },
                          ),
                        ),
                        Divider(
                          height: 10,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        Container(
                          child: ListTile(
                            dense: true,
                            leading: const Icon(Icons.info,color: Colors.black),
                            title: const Text('About Us',style: TextStyle(color: Colors.black),),
                            onTap: () {

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  AboutUs()),
                              );
                            },
                          ),
                        ),
                        Divider(
                          height: 10,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        Container(
                          child: ListTile(
                            dense: true,
                            leading: const Icon(Icons.star_rate,color: Colors.black,),
                            title: const Text('Rate Us',style: TextStyle(color: Colors.black),),
                            onTap: () {

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  RateUs()),
                              );
                            },
                          ),
                        ),
                        Divider(
                          height: 10,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        Container(
                          child: ListTile(
                            dense: true,
                            leading: const Icon(Icons.logout,color: Colors.black),
                            title: const Text('Logout',style: TextStyle(color: Colors.black),),
                            onTap: () {
                              setState(() {
                                App.localStorage.setString("userId", 'null');
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  Login()),
                              );
                            },
                          ),
                        ),
                        Divider(
                          height: 10,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )// Populate the Drawer in the next step.
        ),
        body: Container(
          width: 100.w,
          child: saveStatus?
          ListView.builder(
            shrinkWrap: true,
            itemCount: tourList.length,
            itemBuilder: (context,index){
              print("this is lis data ${tourList[index].gameName}");
                return    Card(
                  margin: EdgeInsets.all(getWidth(10)),
                  child: ListTile(
                    title: text(
                        tourList[index].gameName.toString(),
                      fontSize: 10.sp,
                      textColor: MyColorName.colorTextPrimary,
                      fontFamily: fontBold
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(5.sp),
                      child: Image.network(tourList[index].images.toString(),  width: getWidth(100),
                        height: getHeight(80),fit: BoxFit.fill,),
                    ),
                    trailing: InkWell(
                      onTap: (){

                        DateTime d =  DateTime.parse(tourList[index].endDateTime.toString());
                        int endingTime = d.difference(DateTime.now()).inSeconds;
                        if(double.parse(total.toString()) >= double.parse(minBalance.toString()) || double.parse(total) != 0) {
                          if(endingTime > 10) {
                            enterGame(tourList[index].entryFee.toString(), tourList[index].id.toString(), endingTime, index);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(builder: (context) => CoinFlipScreen(
                            //       endTime: endingTime,
                            //       //DateFormat.jms().format(DateTime.parse(tourList[index].endTime.toString())),
                            //       gameId: tourList[index].id.toString(),
                            //     )));
                          }else{
                            Fluttertoast.showToast(msg: 'Game ended! You can\'t join');
                          }
                        }else{
                          Fluttertoast.showToast(msg: "Minimum balance should be atleast ₹$minBalance in users wallet to enter!");
                        }
                      },
                      child: Container(
                        width: getWidth(120),
                        height: getHeight(50),
                        decoration: boxDecoration(
                          radius: 10.sp,
                          bgColor: MyColorName.primaryLite,
                        ),
                        child: Center(
                          child: !join||checkId!=tourList[index].id.toString()?text(
                            "₹"+tourList[index].entryFee.toString(),
                            fontSize: 8.sp,
                            textColor: MyColorName.colorBg1,
                          ):CircularProgressIndicator(color: MyColorName.colorBg1 ,),
                        ),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text(
                          "Start on " + DateFormat.jms().format(DateTime.parse(tourList[index].startDateTime.toString())),
                          fontSize: 10.sp,
                          textColor: MyColorName.colorTextPrimary,
                        ),
                        text(
                            // endTme.toString(),
                          "Ends on " + DateFormat.jms().format(DateTime.parse(tourList[index].endDateTime.toString())),
                          fontSize: 10.sp,
                          textColor: MyColorName.primaryDark,
                        )
                      ],
                    ),
                    onTap: (){
                      DateTime d =  DateTime.parse(tourList[index].endDateTime.toString());
                      int endingTime = d.difference(DateTime.now()).inSeconds;
                      if(double.parse(total.toString()) >= double.parse(minBalance.toString()) || double.parse(total) != 0) {
                        if(endingTime > 10) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CoinFlipScreen(
                                endTime: endingTime,
                                amount: tourList[index].entryFee.toString(),
                                //DateFormat.jms().format(DateTime.parse(tourList[index].endTime.toString())),
                                gameId: tourList[index].id.toString(),
                                 time: tourList[index].endDateTime.toString()
                                 //DateFormat.jms().format(DateTime.parse(tourList[index].endDateTime.toString()))
                              )));
                        }else{
                          Fluttertoast.showToast(msg: 'Game ended! You can\'t join');
                        }
                      }else{
                        Fluttertoast.showToast(msg: "Minimum balance should be atleast ₹$minBalance in users wallet to enter!");
                      }
                    },

                  ),
                );
            },
          )
              :
          Container(child: Center(child: CircularProgressIndicator(),)),
        ),
      ),
    )
    );
  }
}
