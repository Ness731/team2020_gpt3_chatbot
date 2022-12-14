import 'package:flutter/material.dart';
import 'home.dart';

class Intro extends StatelessWidget {
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c1,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        }, // 키보드 밖의 영역 터치 시 키보드가 내려가도록 함
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.55,
            child: Column(
              children: [
                Text(
                  'GPT-3 Chatbot',
                  style: TextStyle(color: c2, fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 140,
                  margin: const EdgeInsets.only(top: 30, bottom: 30),
                  child: Image.asset('assets/images/bot_logo.png'),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: const Text(
                    '이름을 입력해주세요',
                    style: TextStyle(color: c2, fontSize: 16),
                  ),
                ),
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(bottom: 5),
                  child: TextField(
                    controller: nameController,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: c1, fontSize: 16),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: c2,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(color: c2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(color: c2),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: TextButton(
                    child: const Text(
                      '대화 시작하기',
                      style: TextStyle(color: c2, fontSize: 18),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: c1,
                      side: BorderSide(color: c2, width: 2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () {
                      String userName = nameController.text;
                      nameController.clear();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) => Home(userName)));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
