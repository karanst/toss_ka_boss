import 'dart:async';

import 'package:concoin/models/gaming_history_model.dart';
import 'package:concoin/utils/ApiBaseHelper.dart';
import 'package:concoin/utils/Session.dart';
import 'package:concoin/utils/colors.dart';
import 'package:concoin/utils/common.dart';
import 'package:concoin/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/constant.dart';

class GamingHistory extends StatefulWidget {
  const GamingHistory({Key? key}) : super(key: key);

  @override
  State<GamingHistory> createState() => _GamingHistoryState();
}

class _GamingHistoryState extends State<GamingHistory> {

  bool saveStatus = true;
  ApiBaseHelper apiBase = new ApiBaseHelper();
  List<Data> gamingHistory = [];

  getGamingHistory() async {
    String userId = App.localStorage.getString("userId").toString();
    try {
      setState(() {
        saveStatus = false;
      });
      Map params = {
        "user_id": userId.toString()
        //curUserId.toString(),
      };
      var response =
      await apiBase.postAPICall(Uri.parse(baseUrl + "user_gaming_transactions"), params);
      setState(() {
        saveStatus = true;
      });
      if(response['status']){
        for (var v in response['data']) {
          setState(() {
            gamingHistory.add(Data.fromJson(v));
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
                    gamingHistory[index].status.toString(),
                    fontSize: 12.sp,
                    textColor: gamingHistory[index].status.toString() == "Winner" ? Colors.green :  MyColorName.primaryDark ,
                    fontFamily: fontBold
                ),
                leading: text(
                    gamingHistory[index].gameName.toString(),
                    fontSize: 12.sp,
                    textColor: MyColorName.colorTextPrimary,
                    fontFamily: fontBold
                ),
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
                subtitle: text(gamingHistory[index].updatedAt.toString(),
                  fontSize: 10.sp,
                  textColor: MyColorName.colorTextPrimary,
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10,),
                    text("Entry fees : ₹" +
                        gamingHistory[index].amount.toString(),
                        fontSize: 10.sp,
                        textColor: MyColorName.colorTextPrimary,
                        fontFamily: fontBold
                    ),
                    text(gamingHistory[index].status.toString() == "Winner" ?
                        "+ ₹${gamingHistory[index].totalReturnAmount.toString()}"
                        : "- ₹${gamingHistory[index].totalReturnAmount.toString()}",
                        fontSize: 10.sp,
                        textColor: gamingHistory[index].status.toString() == "Winner" ? Colors.green :  MyColorName.primaryDark ,
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
