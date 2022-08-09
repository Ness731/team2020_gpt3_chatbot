import 'package:flutter/material.dart';
import 'UI/intro.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'text'),
      title: 'OpenAI',
      home: Intro(),
    );
  }
}