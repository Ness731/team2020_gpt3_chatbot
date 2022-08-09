library gpt3_dart;

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

class OpenAI {
  String apiKey;

  OpenAI({required this.apiKey});

  String url = 'https://api.openai.com/v1/engines/text-davinci-002/completions';

  Future<String> complete(String prompt, int maxTokens) async {
    String apiKey = this.apiKey;
    num temperature = 0.8;
    num top_p = 1;
    num frequency_penalty = 0.5;
    num presence_penalty = 0.0;

    Map parameter = {
      "prompt": prompt,
      "max_tokens": maxTokens,
      "temperature": temperature,
      "top_p": top_p,
      "frequency_penalty": frequency_penalty,
      "presence_penalty": presence_penalty,
    };
    Map reqData = {...parameter};

    var response = await http.post(
          Uri.parse(url),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $apiKey",
            HttpHeaders.acceptHeader: "application/json",
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body: jsonEncode(reqData),
        )
        .timeout(const Duration(seconds: 120));

    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> resp = map["choices"];

    return resp[0]["text"];
  }
}
