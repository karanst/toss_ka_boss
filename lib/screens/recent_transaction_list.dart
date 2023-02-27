// ignore_for_file: prefer_const_constructors

import 'package:concoin/models/wallet_model.dart';
import 'package:concoin/utils/Session.dart';
import 'package:concoin/utils/colors.dart';
import 'package:concoin/utils/constant.dart';
import 'package:concoin/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class WalletTransaction extends StatelessWidget {
  List<WalletModel> walletList = [];
  bool saveStatus;

  WalletTransaction(this.walletList, this.saveStatus);

  @override
  Widget build(BuildContext context) {
    return saveStatus
        ? walletList.length > 0
            ? Container(
                child: ListView.builder(
                  itemCount: walletList.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  padding: EdgeInsets.only(bottom: getHeight(20)),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: boxDecoration(
                        radius: 20,
                        bgColor: MyColorName.colorTextFour.withOpacity(0.3),
                      ),
                      margin: EdgeInsets.only(bottom: getHeight(20)),
                      child: ListTile(
                        title: text(getString(walletList[index].type),
                            fontSize: 10.0.sp),
                        subtitle: text(
                            // getDate(
                                walletList[index].date_created.toString(),
                            // ),
                            fontSize: 8.0.sp,
                            textColor: MyColorName.colorTextSecondary
                        ),
                        trailing: SizedBox(
                          width: 20.w,
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.3),
                                      shape: BoxShape.circle),
                                  margin: EdgeInsets.only(right: 5),
                                  child: Icon(
                                    walletList[index].type == "credit"
                                        ? Icons.add
                                        : Icons.remove,
                                    color: Colors.green,
                                  )),
                              Text('₹' + walletList[index].amount),
                            ],
                          ),
                        ),
                        leading: Container(
                          height: 8.h,
                          decoration: BoxDecoration(
                              color: MyColorName.colorBg1,
                              shape: BoxShape.circle),
                          padding: EdgeInsets.all(15),
                          child: Image.asset(
                            "assets/added_to_wallet.png",
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            : Center(
                child: text("No Transaction Available",
                    textColor: MyColorName.colorTextFour),
              )
        : Center(
            child: CircularProgressIndicator(
              color: MyColorName.primaryDark,
            ),
          );
  }
}
