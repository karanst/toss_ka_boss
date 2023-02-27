import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'login.dart';


class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  void _finishIntro(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Login()));
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 600.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Stack(
                        children: [
                          Positioned(
                            top: 90,
                            right: 5,
                            child: Image(
                              alignment: Alignment.center,
                              height: 380,
                              image: AssetImage(
                                'assets/intro1.png',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(40.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Spacer(),
                                Expanded(
                                  child: Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 50),
                                      child: Align(
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                    SizedBox(height: 15.0),
                                    Align(
                                      alignment: Alignment.center,
                                    ),
                                  ],),
                                )

                              ],
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Positioned(
                            top: 90,
                            right: 65,
                            child: Image(
                              alignment: Alignment.center,
                              height: 300,
                              image: AssetImage(
                                'assets/intro2.png',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Positioned(
                            top: 90,
                            right: 45,
                            child: Image(
                              height: 300,
                              image: AssetImage(
                                'assets/intro3.png',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(40.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Spacer(),
                                Expanded(
                                  child: Column(children: [

                                  ],),
                                )

                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                TextButton(
                  onPressed: () => _finishIntro(context),
                  child: Text(
                    'Skip',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // bottomSheet: _currentPage == _numPages - 1
      //     ? Container(
      //  // padding: EdgeInsets.only(bottom: 30),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Container(
      //           height: 50.0,
      //           width: MediaQuery.of(context).size.width * 0.7,
      //           color: Color(0xffff8e09),
      //           child: ElevatedButton(
      //               onPressed: () => _finishIntro(context),
      //               child: Text(
      //                 'Let\'s Go',
      //                 style: TextStyle(
      //                     fontFamily: 'Montserrat', color: Color(0xffff8e09)),
      //               ),
      //               style: ButtonStyle(
      //                 backgroundColor: MaterialStateProperty.all<Color>(
      //                     Colors.black87),
      //                 shape: MaterialStateProperty.all<
      //                     RoundedRectangleBorder>(
      //                   RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.circular(18.0),
      //                   ),
      //                 ),
      //               ))),
      //     ],
      //   ),
      // )
      //     : Text(''),
    );
  }
}
