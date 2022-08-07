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
      appBar: AppBar(
        title: Text(
          '2020 챗봇',
          style: TextStyle(
            color: c2,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            color: c2,
            iconSize: 30,
            onPressed: () {
              _showDialog();
            },
          ),
        ],
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: c1,
        elevation: 0,
      ),
      body: Center(
        child: Text(widget.userName),
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: c1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          content: Container(
            width: (MediaQuery.of(context).size.width) * 0.45,
            height: (MediaQuery.of(context).size.width) * 0.25,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "정말로 대화를 끝내시겠습니까?",
                  style: TextStyle(
                    color: c2,
                    fontSize: 17,
                  ),
                ),
                Text(
                  "대화 기록은 삭제됩니다.",
                  style: TextStyle(
                    color: c2,
                    fontSize: 17,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 30,
                      margin: const EdgeInsets.only(top: 20),
                      child: TextButton(
                        child: Text(
                          "예",
                          style: TextStyle(
                            color: c1,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: c2,
                          side: BorderSide(color: c2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Container(width: 40),
                    Container(
                      width: 80,
                      height: 30,
                      margin: const EdgeInsets.only(top: 20),
                      child: TextButton(
                        child: Text(
                          "아니오",
                          style: TextStyle(
                            color: c1,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: c2,
                          side: BorderSide(color: c2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
