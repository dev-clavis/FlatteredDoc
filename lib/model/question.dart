import 'dart:core';

import 'package:flattereddoctors/model/answer.dart';
import 'package:flattereddoctors/model/questionType.dart';

class Question {
  String question;
  QuestionType type;
  List<Answer> answers = List<Answer>();
  String id;

  int selectedAnswerId = 0;

  Question([this.question, this.type, this.answers]);

  Question.fromJson(Map<String, dynamic> json) {
    this.id = json["qId"];
    this.question = json["name"];

    switch (json["type"]) {
      case "1": this.type = QuestionType.SingleAnswer; break;
      case "2": this.type = QuestionType.MultipleAnswer; break;
      case "3": this.type = QuestionType.TextAnswer; break;
    }

    for(var x in json["ans"]) {
      answers.add(Answer.fromJson(this, x));
    }
  }
}