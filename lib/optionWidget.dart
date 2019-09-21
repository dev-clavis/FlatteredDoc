import 'package:flattereddoctors/model/question.dart';
import 'package:flattereddoctors/model/survey.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OptionWidget extends StatelessWidget {
  const OptionWidget([this.index, this.question]);

  final int index;
  final Question question;

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.all(Radius.circular(24));


    return AnimatedContainer(
        decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: isSelected() ? Colors.purpleAccent : Colors.transparent),
        duration: Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        margin: EdgeInsets.only(bottom: 14),
        child: InkWell(
          borderRadius: borderRadius,
          onTap: () => select(context),
          child: Row(
            children: <Widget>[
              Radio(
                  value: index,
                  groupValue: question.selectedAnswerIndex,
                  activeColor: Colors.white,
                  onChanged: (_) => select(context)),
              Text(question.answers[index])
            ],
          ),
        ));
  }

  void select(BuildContext context) =>
      Provider.of<Survey>(context).onAnswer(question, index);
  bool isSelected() => question.selectedAnswerIndex == index;
}
