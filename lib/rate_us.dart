import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateUs extends StatefulWidget {
  const RateUs({Key? key}) : super(key: key);

  // final String title;

  @override
  State<RateUs> createState() => _RateUsState();
}

class _RateUsState extends State<RateUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "RateUs",
              style: TextStyle(
                fontSize: 20,
              ),
            )),
       );
  }
}
