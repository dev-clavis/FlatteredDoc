import 'package:flattereddoctors/model/answer.dart';
import 'package:flattereddoctors/model/question.dart';
import 'package:flattereddoctors/ui/widgets/optionWidget.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {

  const QuestionWidget({this.question});

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
           Text(question.name, style: Theme.of(context).textTheme.display2),
           Divider(height: 40),
           Column(children: getOptionWidgets(question))
          ]
        )
    );
  }

  List<Widget> getOptionWidgets(Question question) {
    var widgets = new List<Widget>();

    for (Answer answer in question.answers)
      widgets.add(OptionWidget(answer));

    return widgets;
  }
}