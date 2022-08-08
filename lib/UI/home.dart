import 'package:flutter/material.dart';
import 'package:team2020_gpt3_chatbot/model/gpt-3.dart';
import 'package:team2020_gpt3_chatbot/model/chat.dart';

const c1 = Color(0xff90a2f0);
const c2 = Colors.white;

class Home extends StatefulWidget {
  String userName;
  late final OpenAI openAI =
        new OpenAI(apiKey: "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");

  Home(this.userName);

  @override
  State<Home> createState() => _HomeState(openAI);
}

class _HomeState extends State<Home> {
  var textController = TextEditingController();
  final scrollController = ScrollController();

  OpenAI openAI;
  List<Chat> chat = [];
  _HomeState(this.openAI);
  int tokens = 50; // 임시

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
        child: Stack(
          children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 50),
                  child: ListView.builder(
                    itemCount: chat.length,
                    shrinkWrap: true,
                    reverse: false,
                    controller: scrollController,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.only(
                            left: 14, right: 14, top: 10, bottom: 10),
                        child: Align(
                          alignment: (chat[index].isAnswer
                              ? Alignment.topLeft
                              : Alignment.topRight),
                          child: Column(
                            crossAxisAlignment: (chat[index].isAnswer
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.end),
                            children: [
                              Container(
                                alignment: (chat[index].isAnswer
                                    ? Alignment.topLeft
                                    : Alignment.topRight),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: (chat[index].isAnswer
                                      ? Colors.grey.shade200
                                      : c1),
                                ),
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  chat[index].text,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Container(
                        child: TextField(
                          controller: textController,
                          onChanged: (String value) => {},
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: MaterialButton(
                        onPressed: () async {
                          if (textController.value.text.isNotEmpty) {
                            addData(Chat(textController.value.text, false));
                            scrollController.animateTo(
                                scrollController.position.maxScrollExtent,
                                duration: Duration(milliseconds: 100),
                                curve: Curves.linear);

                            String answer = await openAI.complete(
                                textController.text, tokens);
                            if (answer != null) {
                              addData(Chat(answer, true));
                              scrollController.animateTo(
                                  scrollController.position.maxScrollExtent,
                                  duration: Duration(milliseconds: 100),
                                  curve: Curves.linear);
                              setState(() {
                                textController.clear();
                              });
                            }
                          }
                        },
                        child: Icon(Icons.send, size: 30),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
            // width: (MediaQuery.of(context).size.width) * 0.45,
            // height: (MediaQuery.of(context).size.width) * 0.25,
            width: 300,
            height: 150,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "정말로 대화를 끝내시겠습니까?",
                  style: TextStyle(color: c2, fontSize: 18),
                ),
                Text(
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
                        child: Text(
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
                        child: Text(
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
