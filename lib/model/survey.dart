import 'package:flattereddoctors/api/FlatteredDoctorsApi.dart';
import 'package:flattereddoctors/main.dart';
import 'package:flattereddoctors/model/question.dart';
import 'package:flattereddoctors/model/questionType.dart';
import 'package:flutter/cupertino.dart';

class Survey extends ChangeNotifier {

  String title;
  String author;
  String id;
  List<Question> questions;

  // Client side data
  int currentQuestionIndex = 0;
  Question currentQuestion;
  bool isLoading = false;

  static Survey testSurvey = Survey(
      title: "Otaku Umfrage",
      questions: <Question>[
        Question(
            "Welchen Anime findest du müll?",
            QuestionType.SingleAnswer,
            <String>["Eromanga Sensei", "My sister my writer", "die death note netflix adaption"]),
        Question(
            ":ok_hand:",
            QuestionType.SingleAnswer,
            <String>["haha funny :joy:", "not funny didn't laugh"]),
      ]
  );

  void onAnswer(Question question, int index) {
    question.selectedAnswerIndex = index;
    notifyListeners();
  }

  void onQuestion(Question question) async {
    currentQuestion = questions[currentQuestionIndex];
    isLoading = true;
    notifyListeners();
//survey.isLoading ? getLoadingWidget() :
    currentQuestionIndex = questions.indexOf(question);
    var response = await FlatteredDoctorsApi.postAnswerSelection(deviceId, int.parse(id), int.parse(currentQuestion.id), currentQuestion.selectedAnswerIndex + 1);
    var body = response.body;

    isLoading = false;
    notifyListeners();
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
    this.id = json["id"];

    var questions = List<Question>();

    json["0"].forEach((k,v) {
      questions.add(Question.fromJson(v));
    });

    this.questions = questions;
  }
}