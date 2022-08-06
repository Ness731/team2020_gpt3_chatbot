class Chat {
  String script;
  bool isAnswer;

  Chat(this.script, this.isAnswer);

  bool get getIsAnswer => isAnswer;

  String get text => script;

  set setIsAnswer(bool value) {
    isAnswer = value;
  }

  set text(String value) {
    script = value;
  }
}
