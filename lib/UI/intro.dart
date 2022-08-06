import 'package:flutter/material.dart';
import 'home.dart';

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('intro page'),
            TextButton(
              child: Text('home.dart'),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (content) => Home()));
              },
            ),
          ],
        ),
      ),
    );
  }
}