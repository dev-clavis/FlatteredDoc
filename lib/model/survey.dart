import 'package:flattereddoctors/api/FlatteredDoctorsApi.dart';
import 'package:flattereddoctors/main.dart';
import 'package:flattereddoctors/model/answer.dart';
import 'package:flattereddoctors/model/question.dart';
import 'package:flattereddoctors/model/questionType.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class Survey extends ChangeNotifier {

  String title;
  String author;
  int id;
  List<Question> questions;

  // Client side data
  Question currentQuestion;

  static Survey testSurvey = Survey(
      title: "Otaku Umfrage",
      questions: <Question>[
        Question(
            "Welchen Anime findest du müll?",
            QuestionType.SingleAnswer,
            <Answer>[Answer(null, 0, "sorry no stuff")]),
        Question(
            ":ok_hand:",
            QuestionType.SingleAnswer,
            <Answer>[Answer(null, 0, "sorry no stuff")]),
      ]
  );

  void onAnswer(Answer answer, int answerId) {
    assert(answer.id == answerId);
    answer.question.selectedAnswerId = answer.id;
    notifyListeners();
  }

  Future<Response> onQuestion(Question question, int selectedId, bool end) async {
    currentQuestion = question;

    print("question id: ${currentQuestion.id}, device ID: $deviceId, selectedId: $selectedId, survey id: $id");

    var response = await FlatteredDoctorsApi.postAnswerSelection(
        deviceId,
        id,
        currentQuestion.id,
        selectedId);



    print("Antwort als wir die antwort bekommen: ${response.body}");

    notifyListeners();

    return response;
  }

  void copyFrom(Survey survey) {
    this.title = survey.title;
    this.author = survey.author;
    this.id = survey.id;
    this.questions = survey.questions;
    notifyListeners();
  }

  Survey({this.title, this.questions});

  Survey.fromJson(Map<String, dynamic> json) {
    this.title = json["name"];
    this.author = json["author"];
    this.id = int.parse(json["id"]);

    var questions = List<Question>();

    json["0"].forEach((k,v) {
      questions.add(Question.fromJson(v));
    });

    this.questions = questions;
  }
}