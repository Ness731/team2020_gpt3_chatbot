import 'package:translator/translator.dart';

Future<String> translateToEnglish(String input) async {
  final translator = GoogleTranslator();

  var translation = await translator
      .translate(input, from: 'ko', to: 'en');
  print("translation: " + translation.text);

  return translation.text;
}

Future<String> translateToKorean(String input) async {
  final translator = GoogleTranslator();

  var translation = await translator
      .translate(input, from: 'en', to: 'ko');
  print("translation: $translation");

  return translation.text;
}
