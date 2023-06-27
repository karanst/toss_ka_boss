import 'dart:async';
import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:concoin/models/bet_model.dart';
import 'package:concoin/screens/winning_history.dart';
import 'package:concoin/utils/ApiBaseHelper.dart';
import 'package:concoin/utils/Session.dart';
import 'package:concoin/utils/common.dart';
import 'package:concoin/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:toggle_switch/toggle_switch.dart';

import '../utils/constant.dart';

class CoinFlipScreen extends StatefulWidget {
  final int? endTime;
  final String? gameId, amount, time, bgUrl;
  String joinId;
  List<BetModel> betList;
  List<ChoiceModel> choiceList;
  CoinFlipScreen(
      {Key? key,
      this.endTime,
      this.gameId,
      this.amount,
      this.time,
      this.bgUrl,
      required this.betList,
      required this.choiceList,
      required this.joinId})
      : super(key: key);
  @override
  _CoinFlipScreenState createState() => _CoinFlipScreenState();
}

class _CoinFlipScreenState extends State<CoinFlipScreen> {
  late bool _showFrontSide;
  double _distanceFromBottom =
      90; // controls coin's distance from bottom of screen
  bool _isActive = false; // is the coin being flipped right now
  bool _soundOn = true;
  String _face = ''; // initialize string face
  final List<String> faces = ['heads', 'tails'];
  String cartoon = '';
  double _textOpacity = 0; // opacity of the result text
  int _flip_duration = 400;

  final player = AudioCache();

  final int _duration = 60;
  final CountDownController _controller = CountDownController();

  int? coinType = 0;
  Timer? timer;
  var selectCoinFace = 2;

  var selectEnable = true;
  int startTime = 0;
  bool showOption = true;
  bool saveStatus = true;
  ApiBaseHelper apiBase = new ApiBaseHelper();
  String totalHeadUser = '0';
  String totalTailsUser = '0';
  String winningStatus = '';
  String? userId;

  joinedUsers() async {
    try {
      setState(() {
        saveStatus = false;
      });
      Map params = {
        "game_id": widget.gameId.toString(),
        'status': '1'
        //curUserId.toString(),
      };
      var response = await apiBase.postAPICall(
          Uri.parse(baseUrl + "all_join_user"), params);
      if (mounted)
        setState(() {
          saveStatus = true;
        });
      if (!response['error']) {
        setState(() {
          totalHeadUser = response['total_user'];
          // totalTailsUser = response['total_tail_user'];
        });
        // for (var v in response['data']) {
        //   setState(() {
        //     tourList.add(TournamentModel.fromJson(v));
        //   });
        // }
        // for(var i = 0; i < tourList.length; i++){
        //   setState((){
        //     endTme =  DateFormat.jms().format(DateTime.parse(tourList[i].endTime.toString()));
        //   });
        //
        // }
      } else {
        // setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        saveStatus = true;
      });
    }
  }

  getStatus() async {
    try {
      userId = App.localStorage.getString("userId").toString();
      setState(() {
        saveStatus = false;
      });
      Map params = {
        "game_id": widget.gameId.toString(),
        "user_id": userId.toString(),
        'status': '1'
        //curUserId.toString(),
      };
      var response = await apiBase.postAPICall(
          Uri.parse(baseUrl + "user_game_status"), params);
      if (mounted)
        setState(() {
          saveStatus = true;
        });
      if (response['status']) {
        setState(() {
          winCount = response['winner_team'];
          lossCount = response['loss_team'];
          // totalTailsUser = response['total_tail_user'];
        });

        // for (var v in response['data']) {
        //   setState(() {
        //     tourList.add(TournamentModel.fromJson(v));
        //   });
        // }
        // for(var i = 0; i < tourList.length; i++){
        //   setState((){
        //     endTme =  DateFormat.jms().format(DateTime.parse(tourList[i].endTime.toString()));
        //   });
        //
        // }
      } else {
        // setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        saveStatus = true;
      });
    }
  }

  updateUserTime(String time) async {
    userId = App.localStorage.getString("userId").toString();
    try {
      setState(() {
        saveStatus = false;
      });
      Map params = {
        'user_id': userId.toString(),
        'amount': widget.amount.toString(),
        'game_time': time.toString(),
        "game_id": widget.gameId.toString(),
        //curUserId.toString(),
      };
      print("this is updated time data ******* ${params.toString()}");
      var response = await apiBase.postAPICall(
          Uri.parse(baseUrl + "enter_game_users"), params);
      setState(() {
        saveStatus = true;
      });
      if (!response['error'] && response['data'] != null) {
        widget.joinId = response['data'].toString();
      }
      if (response['error']) {
        // setState((){
        //   totalHeadUser = response['total_head_user'];
        //   totalTailsUser = response['total_tail_user'];
        // });
        // for (var v in response['data']) {
        //   setState(() {
        //     tourList.add(TournamentModel.fromJson(v));
        //   });
        // }
        // for(var i = 0; i < tourList.length; i++){
        //   setState((){
        //     endTme =  DateFormat.jms().format(DateTime.parse(tourList[i].endTime.toString()));
        //   });
        //
        // }
      } else {
        // setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        saveStatus = true;
      });
    }
  }

  double amount = 0;
  updateGame(String status) async {
    userId = App.localStorage.getString("userId").toString();
    String? stat;
    if (status == "0") {
      stat = "1";
    } else {
      stat = "2";
    }
    try {
      setState(() {
        saveStatus = false;
      });
      Map params = {
        "user_id": userId.toString(),
        "game_id": widget.gameId.toString(),
        'status': '$stat',
        "amount": amount.toString(),
        "join_id": widget.joinId,
        //curUserId.toString(),
      };
      print("this is joined game request ${params.toString()}");
      var response = await apiBase.postAPICall(
          Uri.parse(baseUrl + "update_gaming_user"), params);
      setState(() {
        saveStatus = true;
      });
      if (response['error']) {
        // setState((){
        //   totalHeadUser = response['total_head_user'];
        //   totalTailsUser = response['total_tail_user'];
        // });
        // for (var v in response['data']) {
        //   setState(() {
        //     tourList.add(TournamentModel.fromJson(v));
        //   });
        // }
        // for(var i = 0; i < tourList.length; i++){
        //   setState((){
        //     endTme =  DateFormat.jms().format(DateTime.parse(tourList[i].endTime.toString()));
        //   });
        //
        // }
      } else {
        Fluttertoast.showToast(msg: response['message']);
        // setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        saveStatus = true;
      });
    }
  }

  winnerTeam() async {
    try {
      setState(() {
        saveStatus = false;
      });
      Map params = {
        "game_id": widget.gameId.toString(),
        'status': '1'
        //curUserId.toString(),
      };
      var response =
          await apiBase.postAPICall(Uri.parse(baseUrl + "winner_team"), params);
      setState(() {
        saveStatus = true;
      });
      print("this is response $response");
      if (response['status']) {
        setState(() {
          winningStatus = response['message'];
        });
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => WinningHistory(
                        gameId: widget.gameId.toString(),
                      )));
        });
        // for (var v in response['data']) {
        //   setState(() {
        //     tourList.add(TournamentModel.fromJson(v));
        //   });
        // }
        // for(var i = 0; i < tourList.length; i++){
        //   setState((){
        //     endTme =  DateFormat.jms().format(DateTime.parse(tourList[i].endTime.toString()));
        //   });
        //
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

  // winnerResult() async {
  //   try {
  //     setState(() {
  //       saveStatus = false;
  //     });
  //     Map params = {
  //       "game_id": widget.gameId.toString(),
  //       'status':'1'
  //       //curUserId.toString(),
  //     };
  //     var response =
  //     await apiBase.postAPICall(Uri.parse(baseUrl + "all_join_user"), params);
  //     setState(() {
  //       saveStatus = true;
  //     });
  //     if(response['error']){
  //       setState((){
  //         totalHeadUser = response['total_head_user'];
  //         totalTailsUser = response['total_tail_user'];
  //       });
  //       // for (var v in response['data']) {
  //       //   setState(() {
  //       //     tourList.add(TournamentModel.fromJson(v));
  //       //   });
  //       // }
  //       // for(var i = 0; i < tourList.length; i++){
  //       //   setState((){
  //       //     endTme =  DateFormat.jms().format(DateTime.parse(tourList[i].endTime.toString()));
  //       //   });
  //       //
  //       // }
  //
  //     }else{
  //       // setSnackbar(response['message'], context);
  //     }
  //
  //   } on TimeoutException catch (_) {
  //     setSnackbar("Something Went Wrong", context);
  //     setState(() {
  //       saveStatus = true;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _showFrontSide = true;
    startTimer();
    startEndTimer();
    getWalletBalance();
    // updateUserTime();
    joinedUsers();
    print("this is end time ${widget.endTime.toString()}");
    DateTime d = DateTime.parse(widget.time.toString());
    int endingTime = d.difference(DateTime.now()).inSeconds;
    myDuration = Duration(seconds: endingTime);
    setState(() {
      startTime = sec;
    });
  }

  Timer? countdownTimer;
  Duration? myDuration;
  String total = '0';

  getWalletBalance() async {
    userId = App.localStorage.getString("userId").toString();
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
            total = response['balance'][0]['balance'];
            // walletList.add(new WalletModel(
            //     v['id'].toString(), v['transaction_type'].toString(), v['user_id'].toString(), v['order_id'].toString(), v['type'].toString(), v['txn_id'].toString(), v['payu_txn_id'].toString(), v['amount'].toString(),
            //     v['status'].toString(), v['currency_code'].toString(), v['payer_email'].toString(), v['message'].toString(), v['transaction_date'].toString(), v['date_created'].toString(), v['total'].toString()));
          });
          print("this is wallet balance $total");
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
    getStatus();
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: timerCount), (timer) {
      callGame();
      joinedUsers();
    });
  }

  void startEndTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: timerCount), (_) => setCountDown());
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration!.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
      if (seconds <= 0) {
        winnerTeam();
      }
    });
  }

  callGame() {
    setState(() {
      startTime--;
      print(startTime);
      if (startTime > 10 && startTime < 51) {
        showOption = false;
      } else {
        showOption = true;
      }
      if (startTime == 0) {
        _controller.restart();
        _restart();
        startTime = 60;
        timer!.cancel();
        startTimer();
        showOption = true;
      }
    });
  }

  @override
  void dispose() {
    if (timer != null) timer!.cancel();
    if (countdownTimer != null) countdownTimer!.cancel();
    player.clearAll();
    super.dispose();
  }

  void _restart() {
    setState(() {
      _distanceFromBottom = 90;
      _textOpacity = 0.0;
      _isActive = false;
      selectCoinFace = 2;
    });
    getWalletBalance();
  }

  // void _soundOnOff() {
  //   setState(() {
  //     _soundOn = !_soundOn;
  //   });
  // }

  void _coinTypeChange() {
    setState(() {
      if (cartoon == '') {
        cartoon = 'cartoon';
      } else {
        cartoon = '';
      }
    });
  }

  Future<bool> onWill() async {
    if (showOption) {
      Navigator.pop(context);
    }
    return false;
  }

  String winCount = "0", lossCount = "0";
  String secs = '';
  int sec = 0;
  int selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits(myDuration!.inDays);
    // Step 7
    final hours = strDigits(myDuration!.inHours.remainder(24));
    final minutes = strDigits(myDuration!.inMinutes.remainder(60));
    secs = strDigits(myDuration!.inSeconds.remainder(60));
    final seconds = strDigits(myDuration!.inSeconds.remainder(60));
    sec = int.parse(seconds.toString());
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    if (secs == "05") {
      print("working here 1 -=======");
      if (selectCoinFace == 0) {
        setState(() {
          selectEnable = false;
          _isActive = true;
          _flipCoin('heads');
        });
      } else {
        if (selectCoinFace == 1) {
          print("working here 2-=======");
          setState(() {
            selectEnable = false;
            _isActive = true;
            _flipCoin('tails');
          });
        } else {
          print("working here 3 -=======");
          setState(() {
            selectEnable = false;
            _isActive = true;
            _flipCoin('No Game');
          });
        }
      }
      Future.delayed(Duration(seconds: 5), () {
        print("restart1");

        if (selectCoinFace == 1 || selectCoinFace == 0) {
          print("restart2");
          updateUserTime("$hours:$minutes:$seconds");
        }
        _restart();
      });
    }

    return WillPopScope(
      onWillPop: onWill,
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(widget.bgUrl!),
              scale: 1,
            )),
            child: Stack(
              children: [
                // Positioned(
                //     left: 10,
                //     top: 10,
                //     child: _soundOn
                //         ? GestureDetector(
                //             onTap: _soundOnOff,
                //             child: Icon(
                //               Icons.volume_up,
                //               size: 40,
                //               color: Colors.orange,
                //             ),
                //           )
                //         : GestureDetector(
                //             onTap: _soundOnOff,
                //             child: Icon(
                //               Icons.volume_off,
                //               size: 40,
                //               color: Colors.orange,
                //             ),
                //           )
                //           ),
                // Positioned(
                //     left: 10,
                //     top: 60,
                //     child: cartoon == ''
                //         ? GestureDetector(
                //             onTap: _coinTypeChange,
                //             child: Icon(
                //               Icons.monetization_on_outlined,
                //               size: 40,
                //               color: Colors.blueAccent,
                //             ),
                //           )
                //         : GestureDetector(
                //             onTap: _coinTypeChange,
                //             child: Icon(
                //               Icons.monetization_on_sharp,
                //               size: 40,
                //               color: Colors.blueAccent,
                //             ),
                //           )),
                AnimatedPositioned(
                  //This is where the coin animation lives
                  duration: Duration(seconds: 2),
                  curve: Curves.bounceOut,
                  bottom: _distanceFromBottom,
                  right: MediaQuery.of(context).size.width * 0.31,
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: _flip_duration),
                    transitionBuilder: __transitionBuilder,
                    child: _showFrontSide ? _buildHeads() : _buildTails(),
                    switchOutCurve: Curves.easeIn.flipped,
                  ),
                ),
                Align(
                  //This is the text that gets displayed after the flip
                  child: AnimatedOpacity(
                    child: Text(
                      '$_face'.toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    duration: Duration(seconds: 1),
                    opacity: _textOpacity,
                  ),
                ),
                Align(
                  //This is the button to replay
                  alignment: Alignment(-0.01, 0.8),
                  child: AnimatedOpacity(
                    child: Container(
                      height: MediaQuery.of(context).size.height * .12,
                      width: MediaQuery.of(context).size.height * .12,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20),
                          primary: Colors.orange, // <-- Button color
                          onPrimary: Colors.white, // <-- Splash color
                        ),
                        child: Text("Play Again"),
                        onPressed: () {
                          setState(() {
                            startTime = 60;
                            timer!.cancel();
                            startTimer();
                            showOption = true;
                          });
                          // _controller.start();
                          _restart();
                        },
                      ),
                    ),
                    duration: Duration(seconds: 1),
                    opacity: _textOpacity,
                  ),
                ),
                Align(
                  //This is the button to replay
                  alignment: Alignment.topRight,
                  child: Container(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        primary: Colors.orange, // <-- Button color
                        onPrimary: Colors.white, // <-- Splash color
                      ),
                      icon: Icon(Icons.wallet),
                      label: Text("₹${total}"),
                      onPressed: () {},
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 0.0, right: 8),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Container(
                //         height: 50,
                //         width: 50,
                //         decoration: BoxDecoration(
                //           border: Border.all(
                //             color: Colors.purpleAccent,
                //             width: 2
                //           ),
                //           color: Colors.white,
                //           shape: BoxShape.circle
                //         ),
                //         child: Center(
                //           child: Text("00:$secs",
                //             style: TextStyle(
                //                 fontWeight: FontWeight.bold,
                //                 color: Colors.purpleAccent,
                //                 fontSize: 14),),
                //         ),
                //       )
                //
                //       // Padding(
                //       //   padding: const EdgeInsets.all(8.0),
                //       //   child: CircularCountDownTimer(
                //       //     duration: _duration,
                //       //     //sec,
                //       //     initialDuration: 0,
                //       //     controller: _controller,
                //       //     width: MediaQuery.of(context).size.width / 10,
                //       //     height: MediaQuery.of(context).size.height / 2,
                //       //     ringColor: Colors.transparent,
                //       //     //Colors.grey[300]!,
                //       //     ringGradient: null,
                //       //     fillColor:
                //       //     // Colors.transparent,
                //       //     Colors.purpleAccent[100]!,
                //       //     fillGradient: null,
                //       //     backgroundColor:
                //       //     Colors.transparent,
                //       //     //Colors.purple[500],
                //       //     backgroundGradient: null,
                //       //     strokeWidth: 5.0,
                //       //     strokeCap: StrokeCap.round,
                //       //     textStyle: TextStyle(
                //       //         fontSize: 12.0,
                //       //         color:
                //       //         //Colors.transparent,
                //       //         Colors.white,
                //       //         fontWeight: FontWeight.bold),
                //       //     textFormat: CountdownTextFormat.MM_SS,
                //       //     isReverse: true,
                //       //     isReverseAnimation: false,
                //       //     isTimerTextShown: true,
                //       //     autoStart: true,
                //       //     onChange: (String val){
                //       //       if(seconds == "0"){
                //       //         if (selectCoinFace == 0) {
                //       //           setState(() {
                //       //             selectEnable = false;
                //       //             _isActive = true;
                //       //             _flipCoin('tails');
                //       //             updateUserTime("$hours:$minutes:$seconds");
                //       //           });
                //       //         } else if (selectCoinFace == 1) {
                //       //           setState(() {
                //       //             selectEnable = false;
                //       //             _isActive = true;
                //       //             _flipCoin('heads');
                //       //             updateUserTime("$hours:$minutes:$seconds");
                //       //           });
                //       //         } else {
                //       //           setState(() {
                //       //             selectEnable = false;
                //       //             _isActive = true;
                //       //             _flipCoin('No Game');
                //       //             updateUserTime("$hours:$minutes:$seconds");
                //       //           });
                //       //         }
                //       //       }
                //       //     },
                //       //     onStart: () {
                //       //       debugPrint('Countdown Started');
                //       //     },
                //       //     onComplete: () {
                //       //       if (selectCoinFace == 0) {
                //       //         setState(() {
                //       //           selectEnable = false;
                //       //           _isActive = true;
                //       //           _flipCoin('tails');
                //       //           updateUserTime("$hours:$minutes:$seconds");
                //       //         });
                //       //       } else if (selectCoinFace == 1) {
                //       //         setState(() {
                //       //           selectEnable = false;
                //       //           _isActive = true;
                //       //           _flipCoin('heads');
                //       //           updateUserTime("$hours:$minutes:$seconds");
                //       //         });
                //       //       } else {
                //       //         setState(() {
                //       //           selectEnable = false;
                //       //           _isActive = true;
                //       //           _flipCoin('No Game');
                //       //           updateUserTime("$hours:$minutes:$seconds");
                //       //         });
                //       //       }
                //       //     },
                //       //   ),
                //       // ),
                //
                //     ],
                //   ),
                // ),
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Choose",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: boxDecoration(
                                        radius: 5.0,
                                        bgColor: Colors.white,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: widget.betList.map((e) {
                                          int index = widget.betList.indexWhere(
                                              (element) => element.id == e.id);
                                          return InkWell(
                                            onTap: () {
                                              if (double.parse(total) <=
                                                  double.parse(
                                                      amount.toString())) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Low balance! update your wallet to play again");
                                              } else {
                                                if (sec >= 10) {
                                                  if (showOption) {
                                                    setState(() {
                                                      selectCoinFace = index;
                                                    });
                                                  }
                                                  print(
                                                      "this is coin result $showOption ***** $selectCoinFace ------ $index");
                                                  /*updateGame(selectCoinFace
                                                      .toString());*/
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "You are not allowed to select in last 10 secs");
                                                }
                                              }
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          e.image!),
                                                      fit: BoxFit.cover)),
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                e.type!,
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Wrap(
                                      // mainAxisSize: MainAxisSize.min,
                                      children: widget.choiceList.map((e) {
                                        int index = [
                                          5,
                                          20,
                                          50,
                                          100
                                        ].indexWhere((element) => element == e);
                                        return Container(
                                          decoration: boxDecoration(
                                            bgColor: Colors.white,
                                            radius: 50.0,
                                            showShadow: true,
                                          ),
                                          margin: EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    if (double.parse(amount
                                                            .toString()) >=
                                                        double.parse(e.amount
                                                            .toString())) {
                                                      setState(() {
                                                        amount -= double.parse(
                                                            e.amount!);
                                                      });
                                                    }
                                                  },
                                                  icon: Icon(Icons.remove)),
                                              Text(
                                                "₹" + e.amount.toString(),
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    if (double.parse(total) <=
                                                        double.parse(amount
                                                            .toString())) {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Low balance! update your wallet to play again");
                                                    } else {
                                                      if (sec >= 10) {
                                                        setState(() {
                                                          amount +=
                                                              double.parse(
                                                                  e.amount!);
                                                        });
                                                      } else {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "You are not allowed to select in last 10 secs");
                                                      }
                                                    }
                                                  },
                                                  icon: Icon(Icons.add)),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(10),
                                ),
                                child: Text(
                                    "BET ₹${amount} on ${selectCoinFace != 2 ? widget.betList[selectCoinFace].type : "?"}"),
                                onPressed: () {
                                  if (selectCoinFace == 2) {
                                    Fluttertoast.showToast(
                                        msg: "Please Select Bet Option");
                                    return;
                                  }
                                  if (amount == 0) {
                                    Fluttertoast.showToast(
                                        msg: "Please Select Amount");
                                    return;
                                  }
                                  if (sec >= 10) {
                                    updateGame(selectCoinFace.toString());
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            "You are not allowed to select in last 10 secs");
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(10),
                                primary: Colors.green, // <-- Button color
                                onPrimary: Colors.white, // <-- Splash color
                              ),
                              child: Text("Win-${winCount}"),
                              onPressed: () {},
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(10),
                                primary: Colors.red, // <-- Button color
                                onPrimary: Colors.white, // <-- Splash color
                              ),
                              child: Text("Lose-${lossCount}"),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      /*Align(
                        alignment: Alignment.center,
                        child: ToggleSwitch(
                          initialLabelIndex: selectCoinFace,
                          totalSwitches: 2,
                          changeOnTap: false,
                          labels: ['Heads', 'Tails'],
                          onToggle: (index) {
                            if (double.parse(total) <=
                                double.parse(widget.amount.toString())) {
                              Fluttertoast.showToast(
                                  msg:
                                      "Low balance! update your wallet to play again");
                            } else {
                              if (sec >= 10) {
                                if (showOption) {
                                  setState(() {
                                    selectCoinFace = index!;
                                  });
                                }
                                print(
                                    "this is coin result $showOption ***** $selectCoinFace ------ $index");
                                updateGame(selectCoinFace.toString());
                              } else {
                                Fluttertoast.showToast(
                                    msg:
                                        "You are not allowed to select in last 10 secs");
                              }
                            }
                          },
                        ),
                      ),*/
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Game ends in : $hours:$minutes:$seconds',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Total joined players : ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                                Text(
                                  "$totalHeadUser",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            // Text(
                            //   'Game ends in  :$seconds',
                            //   style: TextStyle(
                            //       fontWeight: FontWeight.bold,
                            //       color: Colors.white,
                            //       fontSize: 16),
                            // ),
                            // Row(
                            //   children: [
                            //     Text("Total Tails Players : ", style: TextStyle(
                            //         color: Colors.white,
                            //         fontSize: 14
                            //     ),),
                            //     Text("$totalTailsUser", style: TextStyle(
                            //         color: Colors.white,
                            //         fontSize: 14,
                            //         fontWeight: FontWeight.w600
                            //     ),),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.purpleAccent, width: 2),
                                  color: Colors.white,
                                  shape: BoxShape.circle),
                              child: Center(
                                child: Text(
                                  "00:$secs",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.purpleAccent,
                                      fontSize: 14),
                                ),
                              ),
                            )

                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: CircularCountDownTimer(
                            //     duration: _duration,
                            //     //sec,
                            //     initialDuration: 0,
                            //     controller: _controller,
                            //     width: MediaQuery.of(context).size.width / 10,
                            //     height: MediaQuery.of(context).size.height / 2,
                            //     ringColor: Colors.transparent,
                            //     //Colors.grey[300]!,
                            //     ringGradient: null,
                            //     fillColor:
                            //     // Colors.transparent,
                            //     Colors.purpleAccent[100]!,
                            //     fillGradient: null,
                            //     backgroundColor:
                            //     Colors.transparent,
                            //     //Colors.purple[500],
                            //     backgroundGradient: null,
                            //     strokeWidth: 5.0,
                            //     strokeCap: StrokeCap.round,
                            //     textStyle: TextStyle(
                            //         fontSize: 12.0,
                            //         color:
                            //         //Colors.transparent,
                            //         Colors.white,
                            //         fontWeight: FontWeight.bold),
                            //     textFormat: CountdownTextFormat.MM_SS,
                            //     isReverse: true,
                            //     isReverseAnimation: false,
                            //     isTimerTextShown: true,
                            //     autoStart: true,
                            //     onChange: (String val){
                            //       if(seconds == "0"){
                            //         if (selectCoinFace == 0) {
                            //           setState(() {
                            //             selectEnable = false;
                            //             _isActive = true;
                            //             _flipCoin('tails');
                            //             updateUserTime("$hours:$minutes:$seconds");
                            //           });
                            //         } else if (selectCoinFace == 1) {
                            //           setState(() {
                            //             selectEnable = false;
                            //             _isActive = true;
                            //             _flipCoin('heads');
                            //             updateUserTime("$hours:$minutes:$seconds");
                            //           });
                            //         } else {
                            //           setState(() {
                            //             selectEnable = false;
                            //             _isActive = true;
                            //             _flipCoin('No Game');
                            //             updateUserTime("$hours:$minutes:$seconds");
                            //           });
                            //         }
                            //       }
                            //     },
                            //     onStart: () {
                            //       debugPrint('Countdown Started');
                            //     },
                            //     onComplete: () {
                            //       if (selectCoinFace == 0) {
                            //         setState(() {
                            //           selectEnable = false;
                            //           _isActive = true;
                            //           _flipCoin('tails');
                            //           updateUserTime("$hours:$minutes:$seconds");
                            //         });
                            //       } else if (selectCoinFace == 1) {
                            //         setState(() {
                            //           selectEnable = false;
                            //           _isActive = true;
                            //           _flipCoin('heads');
                            //           updateUserTime("$hours:$minutes:$seconds");
                            //         });
                            //       } else {
                            //         setState(() {
                            //           selectEnable = false;
                            //           _isActive = true;
                            //           _flipCoin('No Game');
                            //           updateUserTime("$hours:$minutes:$seconds");
                            //         });
                            //       }
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _flipCoin(String face) async {
    print("coin flipped working here! ${face.toString()}");
    setState(() {
      if (_soundOn) {
        player.play('flip.wav');
      }
      _distanceFromBottom = 420;
      _showFrontSide = !_showFrontSide;
      _face = face;
    });
    Future.delayed(Duration(milliseconds: 3000)).then((value) {
      if (_soundOn) {
        player.play('$face.mp3');
      }
      setState(() {
        _textOpacity = 1.0;
      });
    });
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi * 12, end: 0.0).animate(animation);

    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget!.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.01;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value * 16, pi / 2) : rotateAnim.value;
        if (_face == 'heads') {
          return Transform(
            transform: (Matrix4.rotationX(value)),
            child: (rotateAnim.value < 0.5 ||
                    value > 1.4 && value < 1.5 ||
                    (value > pi / 4 && value < pi / 2) ||
                    (value > pi * 3 && value < pi * 4) ||
                    (value > pi * 5 && value < pi * 6) ||
                    (value > pi * 8 && value < pi * 9))
                ? _buildHeads()
                : _buildTails(),
            alignment: Alignment.center,
          );
        } else {
          return Transform(
            transform: (Matrix4.rotationX(value)),
            child: (rotateAnim.value < 1 ||
                    value > 1.4 && value < 1.5 ||
                    (value > pi / 4 && value < pi / 2) ||
                    (value > pi * 3 && value < pi * 4) ||
                    (value > pi * 5 && value < pi * 6) ||
                    (value > pi * 8 && value < pi * 9))
                ? _buildTails()
                : _buildHeads(),
            alignment: Alignment.center,
          );
        }
      },
    );
  }

  Widget _buildHeads() {
    return __buildLayout(
      key: ValueKey(false),
      faceName: "Heads",
    );
  }

  Widget _buildTails() {
    return __buildLayout(
      key: ValueKey(true),
      faceName: "Tails",
    );
  }

  Widget __buildLayout({required Key key, required String faceName}) {
    return Material(
        color: Colors.transparent,
        shape: CircleBorder(),
        shadowColor: Colors.blue,
        elevation: 10,
        key: key,
        child: Container(
            height: 150,
            child: Center(
              child: faceName == "Heads"
                  ? Image.asset('assets/${cartoon}heads.png')
                  : Image.asset('assets/${cartoon}tails.png'),
            )));
  }
}
