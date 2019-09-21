import 'dart:core';

import 'package:flattereddoctors/model/questionType.dart';

class Question {
  final String question;
  final QuestionType type;
  final List<String> answers;

  int selectedAnswerIndex;

  Question([this.question, this.type, this.answers]);
}