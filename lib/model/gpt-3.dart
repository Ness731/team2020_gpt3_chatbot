library gpt3_dart;

class Param {
  String name;
  var value;

  Param(this.name, this.value);

  @override
  String toString() {
    return '{ ${this.name}, ${this.value} }';
  }
}
class OpenAI {
  String apiKey;
  OpenAI({required this.apiKey});

}