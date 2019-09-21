import 'package:flattereddoctors/model/question.dart';
import 'package:flattereddoctors/model/questionType.dart';
import 'package:flutter/cupertino.dart';

class Survey extends ChangeNotifier {

  final String title;
  final List<Question> questions;

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

  Survey({this.title, this.questions});
}