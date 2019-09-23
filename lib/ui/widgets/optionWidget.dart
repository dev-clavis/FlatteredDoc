import 'package:flattereddoctors/model/answer.dart';
import 'package:flattereddoctors/model/survey.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OptionWidget extends StatelessWidget {
  const OptionWidget([this.answer]);

  final Answer answer;

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.all(Radius.circular(24));

    void select(int id) => Provider.of<Survey>(context).onAnswer(answer, id);

    return AnimatedContainer(
        decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: isSelected() ? Colors.purpleAccent : Colors.transparent),
        duration: Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        margin: EdgeInsets.only(bottom: 14),
        child: InkWell(
          borderRadius: borderRadius,
          onTap: () => select(answer.id),
          child: Row(
            children: <Widget>[
              Radio(
                  value: answer.id,
                  groupValue: answer.question.selectedAnswerId,
                  activeColor: Colors.white,
                  onChanged: select
              ),
              Text(answer.name)
            ],
          ),
        ));
  }


  bool isSelected() => answer.question.selectedAnswerId == answer.id;
}
