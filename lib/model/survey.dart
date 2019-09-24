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

  Future<int> get answeredBefore async => await FlatteredDoctorsApi.wasAnsweredBefore(deviceId, id);

  // Client side data
  Question currentQuestion;
  bool local;

  static Survey testSurvey = Survey(
    title: "Debug Umfrage",
    questions: <Question>[
      Question(
        null,
        "Wie fandest du den PIT-Hackathon",
        QuestionType.SingleAnswer,
        <Answer>[
          Answer(null, 1, "Ziemlich gut"),
          Answer(null, 2, "Gut"),
          Answer(null, 3, "Geht so"),
          Answer(null, 4, "Könnte besser sein"),
          Answer(null, 5, "Schlecht"),
        ]
      )
    ]
  );

  void onAnswer(Answer answer, int answerId) {
    assert(answer.id == answerId);
    answer.question.selectedAnswerId = answer.id;
    notifyListeners();
  }

  Future<Response> onQuestion(Question question, int selectedId, bool end) async {
    currentQuestion = question;

    if (local) {
      print("Ignored sending request because survey is local.");
      notifyListeners();
      return null;
    } else {
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
  }

  void copyFrom(Survey survey) {
    this.title = survey.title;
    this.author = survey.author;
    this.id = survey.id;
    this.questions = survey.questions;
    this.local = survey.local;
    notifyListeners();
  }

  Survey({this.title, this.questions}) {
    this.local = true;
    for (Question question in this.questions) {
      question.survey = this;
    }
  }

  Survey.fromJson(Map<String, dynamic> json) {
    this.title = json["name"];
    this.author = json["author"];
    this.id = int.parse(json["id"]);

    var questions = List<Question>();

    json["0"].forEach((k,v) {
      questions.add(Question.fromJson(this, v));
    });

    this.questions = questions;
  }
}