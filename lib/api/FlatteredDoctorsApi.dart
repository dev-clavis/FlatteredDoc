import 'dart:convert';
import 'dart:io';

import 'package:flattereddoctors/model/survey.dart';
import 'package:http/http.dart' as http;



class FlatteredDoctorsApi {
  static String _server = "http://172.16.0.1:8001";

  static Future<Survey> getSurvey (int id) async {
    //await http.post("$_server/")

    var response = await http.get("$_server/req.php?id=$id");
    var jsonMap = json.decode(response.body);
    return Survey.fromJson(jsonMap);
  }

  static Future<http.Response> postAnswerSelection(String userId, int surveyId, int questionId, int answerId) async {
    var data = {
      "uId": 6969,//userId
      "umId": 65,
      "qId" : 1,
      "aId": 1
    };

    var jsonString = json.encode(data);
    return await http.post("$_server/add.php", headers: {
      "content-type": "application/json",
      "accept": "text/plain"
      }, body: jsonString);

  }

  //static String getError(http.Response response) {
  //      try {
  //        var jsonString = json.decode(response.body);
  //      } catch {
  //        print("failed to stuff");
  //      }
  //}
}

