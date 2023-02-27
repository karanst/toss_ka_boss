import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: (){},
                child: Text('Contact Us'),
            ),
          ],
        ),
      ),
    );
  }
}
