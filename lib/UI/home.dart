import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:team2020_gpt3_chatbot/model/gpt-3.dart';
import 'package:team2020_gpt3_chatbot/model/chat.dart';

import '../model/translator.dart';

const c1 = Color(0xff90a2f0);
const c2 = Colors.white;

class Home extends StatefulWidget {
  String userName;
  static String OPEN_AI_KEY = ''; // * key 입력 후 실행하세요

  late final OpenAI openAI =
      new OpenAI(apiKey: OPEN_AI_KEY);

  Home(this.userName);

  @override
  State<Home> createState() => _HomeState(openAI, userName);
}

class _HomeState extends State<Home> {
  var textController = TextEditingController();
  final scrollController = ScrollController();
  String userName;
  OpenAI openAI;
  List<Chat> chat = [];
  int tokens = 15;

  _HomeState(this.openAI, this.userName);

  void addData(Chat data) {
    setState(() {
      chat.add(data);
    });
  }

  @override
  void dispose() {
    textController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  String date = '';

  String getToday() {
    DateTime now = DateTime.now();
    String today = DateFormat('yyyy/MM/dd').format(now);
    return today;
  }

  String dateCheck() {
    if (date != getToday()) {
      date = getToday();
      return date;
    }
    return '';
  }

  bool hasDateChanged(Chat pre){
    return (pre.date.compareTo(getToday()) != 0); // 직전 메시지와 날짜가 다른 경우 true
  }

  String getTime() {
    DateTime now = DateTime.now();
    String time = DateFormat('HH:mm').format(now);
    return time;
  }

  bool flag = false;

  void addStartScript(){
    String chatDate = dateCheck();
    String startScript = "만나서 반가워 " + this.userName + "!\n"
        "나는 인공지능 챗봇 OO이야 :)\n"
        "우리 대화를 시작해볼까?";
    addData(Chat(chatDate, getTime(), startScript, true));
    if(flag == false)
      flag = true;
  }

  @override
  Widget build(BuildContext context) {
    if(flag == false)
      addStartScript();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '2020 챗봇',
          style: TextStyle(
            color: c2,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: const Icon(Icons.logout),
              color: c2,
              iconSize: 30,
              onPressed: () {
                _showDialog();
              },
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: c1,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // 영역 밖 터치 시 키보드 내리기
        },
        child: Center(
          child: Stack(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(bottom: 65),
                child: ListView.builder(
                  itemCount: chat.length,
                  shrinkWrap: true,
                  reverse: false,
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 14),
                      child: Column(
                        children: [
                          if(index == 0 || hasDateChanged(chat[index-1]))
                            Container(
                              margin: (chat[index].date != ''
                                  ? const EdgeInsets.only(bottom: 20)
                                  : const EdgeInsets.all(0)),
                              child: Text(
                                chat[index].date,
                                style: const TextStyle(
                                  color: c1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          Container(
                            alignment: (chat[index].isAnswer
                                ? Alignment.topLeft
                                : Alignment.topRight),
                            margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                            child: Text(
                              (chat[index].isAnswer
                                  ? 'chatbot'
                                  : widget.userName),
                              style: TextStyle(
                                color: (chat[index].isAnswer
                                    ? c1
                                    : Colors.grey.shade400),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: (chat[index].isAnswer
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.end),
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if(chat[index].isAnswer == false)
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: Text(
                                      chat[index].time,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: (chat[index].isAnswer
                                      ? Colors.grey.shade200
                                      : c1),
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  chat[index].script,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: (chat[index].isAnswer
                                        ? Colors.black
                                        : c2),
                                  ),
                                ),
                              ),
                              if(chat[index].isAnswer)
                                Container(
                                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child: Text(
                                    chat[index].time,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: c1,
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: c2,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 15),
                            child: TextField(
                              controller: textController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                              onChanged: (String value) => {},
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: MaterialButton(
                            onPressed: () async {
                              String chatDate = dateCheck();
                              String text = textController.text;

                              if (text.isNotEmpty) {
                                addData(Chat(chatDate, getTime(), text, false));

                                scrollController.animateTo(
                                    scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 100),
                                    curve: Curves.linear);

                                String translatedText = await translateToEnglish(text);

                                String answer =
                                    await openAI.complete(translatedText, tokens);

                                String translatedAnswer = await translateToKorean(answer);

                                if (answer != null) {
                                  addData(Chat(chatDate, getTime(), translatedAnswer, true));

                                  scrollController.animateTo(
                                      scrollController.position.maxScrollExtent,
                                      duration:
                                          const Duration(milliseconds: 100),
                                      curve: Curves.linear);

                                  textController.clear();
                                }
                              }
                            },
                            child: const Icon(Icons.send, size: 30, color: c1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // dialog 밖의 영역을 터치해도 닫히지 않도록 함
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: c1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          content: Container(
            width: 300,
            height: 150,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "정말로 대화를 끝내시겠습니까?",
                  style: TextStyle(color: c2, fontSize: 18),
                ),
                const Text(
                  "대화 기록은 삭제됩니다.",
                  style: TextStyle(color: c2, fontSize: 18),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      margin: const EdgeInsets.only(top: 20),
                      child: TextButton(
                        child: const Text(
                          "예",
                          style: TextStyle(color: c1, fontSize: 16),
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
                      margin: const EdgeInsets.only(top: 20),
                      child: TextButton(
                        child: const Text(
                          "아니오",
                          style: TextStyle(color: c1, fontSize: 16),
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
