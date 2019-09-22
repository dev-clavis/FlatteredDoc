import 'dart:convert';
import 'dart:io';

import 'package:flattereddoctors/model/survey.dart';
import 'package:http/http.dart' as http;



class FlatteredDoctorsApi {
  static String _server = "http://172.16.0.1:8001";

  static Future<Survey> getSurvey (int id) async {
    //await http.post("$_server/")

    var response = await http.get("$_server/req.php?id=$id");

    assert(response.statusCode != 500);

    var jsonMap = json.decode(response.body);
    return Survey.fromJson(jsonMap);
  }

  static Future<http.Response> postAnswerSelection(String userId, int surveyId, int questionId, int answerId) async {
    var data = {
      "uId": userId,
      "umId": surveyId,
      "qId" : questionId,
      "aId": answerId
    };

    var jsonString = json.encode(data);
    var response = await http.post("$_server/add.php", headers: {
      "content-type": "application/json",
      "accept": "text/plain"
    }, body: jsonString);

    var error = getError(response);
    if (error != null)
      throw new Exception("API wollte nicht, sorry. $error");

    return response;
  }

  static Future<int> wasAnsweredBefore(String userId, int surveyId) async {
    return 0;

    var data = {
      "uId": userId,
      "umId": surveyId
    };

    print("Device ID: $userId; Umfragen-Id : $surveyId");

    var jsonString = json.encode(data);
    var response = await http.post("$_server/validate.php", headers: {
      "content-type": "application/json",
      "accept": "text/plain"
    }, body: jsonString);

    try {
      return int.parse(response.body);
    } catch (ex) {
      print("=============================\nKonnte nicht checken ob die Umfrage schon teilgenommen wurde:");
      print("Flutter Exception: ${ex.toString()}\n-------------------------");
      print("HTTP Body: ${response.body}\n=============================");
      return null;
    }
  }

  static String getError(http.Response response) {
    try {
      var jsonMap = json.decode(response.body);
      String error = jsonMap["error"];

      if(error != null && error.isNotEmpty)
        return jsonMap["error"];

      return null;
    } catch (ex){
      print("Failed to read json, pretending there's no error");
      return null;
    }
  }
}

