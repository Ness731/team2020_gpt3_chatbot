import 'package:flutter/material.dart';
import 'home.dart';

class Intro extends StatelessWidget {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c1,
      body: Center(
        child: Container(
          width: (MediaQuery.of(context).size.width) * 0.6,
          height: (MediaQuery.of(context).size.height) * 0.5,
          child: Column(
            children: [
              Container(
                // app logo 넣기
                alignment: Alignment.center,
                width: 200,
                height: 100,
                color: c2,
                margin: const EdgeInsets.only(bottom: 60),
                child: Text(
                  'app logo',
                  style: TextStyle(
                    color: c1,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 5),
                child: Text(
                  '이름을 입력해주세요',
                  style: TextStyle(
                    color: c2,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.only(bottom: 5),
                child: TextField(
                  controller: _nameController,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: c1,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: c2,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: c2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: c2,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: TextButton(
                  child: Text(
                    '대화 시작하기',
                    style: TextStyle(
                      color: c2,
                      fontSize: 18,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: c1,
                    side: BorderSide(color: c2, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (content) => Home(_nameController.text)));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
