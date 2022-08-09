import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Papago {
  String client_id = "HDARwJNgVsAilV75Mipc";
  String client_secret = "rEDlbf6FHU";
  String content_type = "application/x-www-form-urlencoded; charset=UTF-8";
  String url = "https://openapi.naver.com/v1/papago/n2mt";
  var Target = ['ko', 'en'];

  Future<String> translate(String script, String source, String target) async {
    if(!Target.contains(target)){
      return "번역기 오류 : 지원하지 않는 언어";
    }

    var response = await http.post(
      Uri.parse(url),
      headers: ({
        "X-Naver-Client-Id": client_id,
        "X-Naver-Client-Secret": client_secret,
        "Content-Type": content_type
      }),
      body: ({
        "source": source,//위에서 언어 판별 함수에서 사용한 language 변수
        "target": target,
        "text": script
      }),
    );
    Map<String, dynamic> map = json.decode(response.body);
    var translated = map['message']['result']['translatedText'];
    return translated;
  }
}