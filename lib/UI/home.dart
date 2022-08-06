import 'package:flutter/material.dart';

const c1 = Color(0xff90a2f0);
const c2 = Colors.white;

class Home extends StatefulWidget {
  String userName;
  Home(this.userName);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(widget.userName),
            TextButton(
              child: Text('intro 화면으로 돌아가기'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ), // 수정할 곳
      ),
    );
  }
}
