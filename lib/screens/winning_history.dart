import 'dart:async';

import 'package:concoin/models/gaming_history_model.dart';
import 'package:concoin/models/winning_history_model.dart';
import 'package:concoin/utils/ApiBaseHelper.dart';
import 'package:concoin/utils/Session.dart';
import 'package:concoin/utils/colors.dart';
import 'package:concoin/utils/common.dart';
import 'package:concoin/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/constant.dart';

class WinningHistory extends StatefulWidget {
  final String? gameId;
  const WinningHistory({Key? key, this.gameId}) : super(key: key);

  @override
  State<WinningHistory> createState() => _WinningHistoryState();
}

class _WinningHistoryState extends State<WinningHistory> {

  bool saveStatus = true;
  ApiBaseHelper apiBase = new ApiBaseHelper();
  List<Winners> gamingHistory = [];

  getGamingHistory() async {
    // String userId = App.localStorage.getString("userId").toString();
    try {
      setState(() {
        saveStatus = false;
      });
      Map params = {
        "game_id": widget.gameId.toString(),
        //curUserId.toString(),
      };
      var response =
      await apiBase.postAPICall(Uri.parse(baseUrl + "winner_list"), params);
      setState(() {
        saveStatus = true;
      });
      if(response['status']){
        for (var v in response['data']) {
          setState(() {
            gamingHistory.add(Winners.fromJson(v));
          });
        }
        // for(var i = 0; i < gamingHistory.length; i++){
        //   setState((){
        //     endTme =  DateFormat.jms().format(DateTime.parse(gamingHistory[i].endTime.toString()));
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGamingHistory();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  MyColorName.appbarBg,
      appBar: AppBar(
        // centerTitle: true,
        title: Text(
          "Gaming History",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
      ),
      body: saveStatus?
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: gamingHistory.length,
          itemBuilder: (context,index){
            return    Card(
              margin: EdgeInsets.all(getWidth(10)),
              child: ListTile(
                title: text(
                    gamingHistory[index].userName.toString(),
                    fontSize: 14.sp,
                    textColor: MyColorName.primaryDark,
                    fontFamily: fontBold
                ),
                // leading: text(
                //     gamingHistory[index].gameName.toString(),
                //     fontSize: 12.sp,
                //     textColor: MyColorName.colorTextPrimary,
                //     fontFamily: fontBold
                // ),
                // trailing: InkWell(
                //   onTap: (){
                //     setState((){
                //       checkId = gamingHistory[index].id.toString();
                //     });
                //     joinTournament();
                //     enterGame(gamingHistory[index].entryFee.toString());
                //   },
                //   child: Container(
                //     width: getWidth(120),
                //     height: getHeight(50),
                //     decoration: boxDecoration(
                //       radius: 10.sp,
                //       bgColor: MyColorName.primaryLite,
                //     ),
                //     child: Center(
                //       child: !join||checkId!=gamingHistory[index].id.toString()?text(
                //         "₹"+gamingHistory[index].entryFee.toString(),
                //         fontSize: 8.sp,
                //         textColor: MyColorName.colorBg1,
                //       ):CircularProgressIndicator(color: MyColorName.colorBg1 ,),
                //     ),
                //   ),
                // ),
                subtitle: text("Winner",
                  fontSize: 10.sp,
                  textColor: Colors.green,
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10,),
                    text("Entry fees : ₹" +
                        gamingHistory[index].entryFee.toString(),
                        fontSize: 12.sp,
                        textColor: MyColorName.colorTextPrimary,
                        fontFamily: fontBold
                    ),
                    text(
                    "₹ ${gamingHistory[index].winningAmount.toString()}",
                        fontSize: 12.sp,
                        textColor: MyColorName.colorTextPrimary,
                        fontFamily: fontBold
                    ),
                  ],
                ),
                onTap: (){
                  // print("started");
                  // if(double.parse(total.toString()) >= double.parse(minBalance.toString()) || double.parse(total) != 0) {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => CoinFlipScreen()));
                  // }else{
                  //   Fluttertoast.showToast(msg: "Minimum balance should be atleast ₹$minBalance in users wallet to enter!");
                  //   print("this is else");
                  // }
                },

              ),
            );
          },
        ),
      ):Container(child: Center(child: CircularProgressIndicator(),)),
    );
  }
}
