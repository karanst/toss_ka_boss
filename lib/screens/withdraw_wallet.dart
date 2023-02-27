import 'dart:async';

import 'package:concoin/utils/ApiBaseHelper.dart';
import 'package:concoin/utils/Session.dart';
import 'package:concoin/utils/colors.dart';
import 'package:concoin/utils/common.dart';
import 'package:concoin/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {

  bool isUpi = false;
  int _value = 1;
  TextEditingController upiController = TextEditingController();
  TextEditingController accountHolderController = TextEditingController();
  TextEditingController accountNoController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController confmAccountNumController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  var accTypeValue;
  List accountType = [
    'Savings',
    'Current'
  ];
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  bool saveStatus = false;
  String userId = "";

  withdrawWallet() async {
    userId = App.localStorage.getString("userId").toString();
    try {
      setState(() {
        saveStatus = true;
      });
      Map params = {
        "user_id": userId.toString(),
        //curUserId.toString(),
        "amount": amountController.text.toString(),
        "payment_address" : isUpi
            ? '{"account_holder_name" : "${accountHolderController.text.toString()}","account_number" : "${accountNoController.text.toString()}","bank_name" : "${bankNameController.text.toString()}","account_type": "${accTypeValue.toString()}","ifsc_code" : "${ifscController.text.toString()}"}'
            : '{"UPI" : "${upiController.text.toString()}"}'
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl + "send_withdrawal_request"), params);
      setState(() {
        saveStatus = false;
      });
      if (!response['error']) {
        Navigator.pop(context,"yes");
        Fluttertoast.showToast(msg: response['message']);
        // setSnackbar(response['message'], context);
      } else {
        Fluttertoast.showToast(msg: response['message']);
        // setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        saveStatus = false;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  MyColorName.appbarBg,
      appBar: AppBar(
        // centerTitle: true,
        title: Text(
          "Withdraw",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: MyColorName.colorBg1)
                ),
                // height: 50,
                child: TextFormField(
                    controller: amountController,
                    validator: (msg) {
                      if (msg!.isEmpty) {
                        return "Please Amount";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Amount",
                        contentPadding: EdgeInsets.only(left: 10),
                        border: InputBorder.none
                    )
                  // decoration: InputDecoration(
                  //   border: OutlineInputBorder(),
                  // ),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                        value: 1,
                        fillColor: MaterialStateColor.resolveWith((states) => MyColorName.colorBg1),
                        groupValue: _value,
                        onChanged: (int? value) {
                          setState(() {
                            _value = value!;
                            isUpi = false;
                          });
                        }),
                    Text(
                      "Bank Upi",
                      style: TextStyle(color: MyColorName.colorBg1),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                        value: 2,
                        fillColor: MaterialStateColor.resolveWith((states) => MyColorName.colorBg1),
                        groupValue: _value,
                        onChanged: (int? value) {
                          setState(() {
                            _value = value!;
                            isUpi = true;
                          });
                        }),
                    Text(
                      "Bank Account",
                      style: TextStyle(color: MyColorName.colorBg1),
                    ),
                  ],
                ),
              ],
            ),
            isUpi == false
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text('UPI Id', style: TextStyle(
                      color: MyColorName.colorBg1
                  ),),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: MyColorName.colorBg1)
                  ),
                  // height: 50,
                  child: TextFormField(
                      controller: upiController,
                      validator: (msg) {
                        if (msg!.isEmpty) {
                          return "Please Enter UPI Id ";
                        }
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10),
                          border: InputBorder.none
                      )
                    // decoration: InputDecoration(
                    //   border: OutlineInputBorder(),
                    // ),
                  ),
                ),
              ],
            )
                : SizedBox.shrink(),
            isUpi == true
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text('Account Holder Name',style: TextStyle(
                      color: MyColorName.colorBg1
                  ),),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: MyColorName.colorBg1)
                  ),
                  // height: 50,
                  child: TextFormField(
                      controller: accountHolderController,
                      // validator: (msg) {
                      //   if (msg!.isEmpty) {
                      //     return "Please Enter Account Holder Name ";
                      //   }
                      // },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10 ),
                          border: InputBorder.none
                        // OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(5))
                      )
                    // decoration: InputDecoration(
                    //   border: OutlineInputBorder(),
                    // ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text('Account Number',
                    style: TextStyle(
                        color: MyColorName.colorBg1
                    ),),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: MyColorName.colorBg1)
                  ),
                  // height: 50,
                  child: TextFormField(
                      controller: accountNoController,
                      keyboardType: TextInputType.number,
                      validator: (msg) {
                        if (msg!.isEmpty) {
                          return "Please Enter Account Number";
                        }
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10 ),
                          counterText: "",
                          border: InputBorder.none
                      )
                    // decoration: InputDecoration(
                    //   border: OutlineInputBorder(),
                    // ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 10),
                //   child: Text('Confirm Account Number',style: TextStyle(
                //       color: MyColorName.colorBg1
                //   ),),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // Container(
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(5),
                //       border: Border.all(color: MyColorName.colorBg1)
                //   ),
                //   // height: 50,
                //   child: TextFormField(
                //       controller: confmAccountNumController,
                //       keyboardType: TextInputType.number,
                //       // validator: (msg) {
                //       // if(msg != confmAccountNumController.text){
                //       //   return "Account number and confirm account number must be same";
                //       // }
                //       // },
                //       decoration: InputDecoration(
                //           contentPadding: EdgeInsets.only(left: 10 ),
                //           counterText: "",
                //           border: InputBorder.none
                //       )
                //     // decoration: InputDecoration(
                //     //   border: OutlineInputBorder(),
                //     // ),
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text('Bank Name',style: TextStyle(
                      color: MyColorName.colorBg1
                  ),),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: MyColorName.colorBg1)
                  ),
                  // height: 50,
                  child: TextFormField(
                      controller: bankNameController,
                      // validator: (msg) {
                      //   if (msg!.isEmpty) {
                      //     return "Please Enter Bank Name ";
                      //   }
                      // },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10),
                          border: InputBorder.none
                      )
                    // decoration: InputDecoration(
                    //   border: OutlineInputBorder(),
                    // ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text('IFSC Code',style: TextStyle(
                      color: MyColorName.colorBg1
                  ),),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: MyColorName.colorBg1)
                  ),
                  child: TextFormField(
                      controller: ifscController,
                      // validator: (msg) {
                      //   if (msg!.isEmpty) {
                      //     return "Please Enter IFSC Code";
                      //   }
                      // },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10 ),
                          border: InputBorder.none
                      )
                    // decoration: InputDecoration(
                    //   border: OutlineInputBorder(),
                    // ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text('Account Type',style: TextStyle(
                      color: MyColorName.colorBg1
                  ),),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color: MyColorName.colorBg1,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: MyColorName.colorBg1)),
                    child: DropdownButton(
                      // Initial Value
                      value: accTypeValue,
                      underline: Container(),
                      isExpanded: true,
                      // Down Arrow Icon
                      icon: Icon(Icons.keyboard_arrow_down, color: MyColorName.primaryLite,),
                      hint: Text("Select Account Type", style: TextStyle(
                          color: MyColorName.primaryLite
                      ),),
                      // Array list of items
                      items: accountType.map((items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Container(
                              child: Text(items.toString())),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (newValue) {
                        setState(() {
                          accTypeValue = newValue!;
                          print(
                              "selected category ${accTypeValue.toString()}");
                        });
                      },
                    ),
                  ),
                ),
              ],
            )
                : SizedBox.shrink(),
            const SizedBox(height: 30,),
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
                  'Withdraw Money',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              onPressed: () {
                if(amountController.text.isEmpty){
                  Fluttertoast.showToast(msg: "Please enter amount first!");
                }else{
                  if(isUpi == false){
                    if(upiController.text.isNotEmpty){
                      withdrawWallet();
                    }else{
                      Fluttertoast.showToast(msg: "Please Enter valid UPI Id!");
                      // setSnackbar("Please Enter valid UPI Id!", context);
                    }
                  }else{
                    if(amountController.text.isNotEmpty) {
                      if (bankNameController.text.isNotEmpty ||
                          accountNoController.text.isNotEmpty ||
                          ifscController.text.isNotEmpty ||
                          accountHolderController.text.isNotEmpty) {
                        withdrawWallet();
                      } else {
                        Fluttertoast.showToast(
                            msg: "Please Enter valid Bank Details!");
                        // setSnackbar("Please Enter valid Bank Details!", context);
                      }
                    }else{
                      Fluttertoast.showToast(msg: "Please enter amount first!");
                    }
                  }

                  // setSnackbar("Please enter amount first!", context);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
