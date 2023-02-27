import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';




class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  CarouselController buttonCarouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              color: Color(0xff004879),
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(height: 400.0),
                    items: [1,2,3,4,5].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                  color: Colors.amber
                              ),
                              child: Text('text $i', style: TextStyle(fontSize: 16.0),)
                          );
                        },
                      );
                    }).toList(),
                  ),
                  CarouselSlider(
                    items: [],
                    carouselController: buttonCarouselController,
                    options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      viewportFraction: 0.9,
                      aspectRatio: 2.0,
                      initialPage: 2,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => buttonCarouselController.nextPage(
                        duration: Duration(milliseconds: 300), curve: Curves.linear),
                    child: Text('→'),
                  )
                ],

              ),
            ),
          ],
        ),
      ),
    );
  }
}
