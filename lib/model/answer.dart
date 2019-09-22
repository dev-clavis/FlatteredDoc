import 'package:flattereddoctors/model/question.dart';

class Answer {
  int id;
  String name;
  Question question;

  Answer([this.question, this.id , this.name]);

  Answer.fromJson([this.question, Map<String, dynamic> json]) {
    this.id = int.parse(json["optionId"]);

    print("Antwort ID ist $id");

    assert(this.id != 0);

    this.name = json["optionName"];
  }
}