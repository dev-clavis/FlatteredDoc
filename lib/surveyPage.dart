import 'package:flattereddoctors/model/question.dart';
import 'package:flattereddoctors/model/questionType.dart';
import 'package:flattereddoctors/model/survey.dart';
import 'package:flattereddoctors/optionWidget.dart';
import 'package:flattereddoctors/ui/questionWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SurveyPage extends StatelessWidget {
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Consumer<Survey>(
        builder: (context, survey, child) => Scaffold(
            appBar: AppBar(title: Text(survey.title)),
            body: Column(
              children: <Widget>[
                Expanded(
                    child: PageView(
                      controller: _pageController,
                  children: getQuestionPages(Survey.testSurvey),
                  physics: NeverScrollableScrollPhysics(),
                  //onPageChanged: (ni) => { this._currentPage = ni},
                )),

                Padding(
                padding: EdgeInsets.all(5),
                child:Row(

                  children: <Widget>[
                    //IconButton(icon: Icon(Icons.chevron_left), onPressed: () => _pageController.jumpToPage(getCurrentPage()-1)),
                    //IconButton(icon: Icon(Icons.chevron_left), onPressed: () => _pageController.jumpToPage(getCurrentPage()-1)),
                    Expanded(
                        child: Row(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 8, right: 16),
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(left: 6, top: 6),
                                    child: Icon(Icons.flag, size: 24)),
                                CircularProgressIndicator(value: getCurrentPage() / survey.questions.length)
                              ],
                            )),
                        Text("Frage ${getCurrentPage()} von ${survey.questions.length}",
                            textAlign: TextAlign.left)
                      ],
                    )),
                    IconButton(icon: Icon(Icons.chevron_right), onPressed: () => _pageController.jumpToPage(getCurrentPage()+1))
                  ],
                ))
              ],
            )));
  }

  int getCurrentPage() {
    try {
      return _pageController.page.round();
    } catch (Exception) {
      return 0;
    }
  }

  List<Widget> getQuestionPages(Survey survey) {
    var widgets = List<Widget>();

    for (var question in survey.questions) {
      widgets.add(QuestionWidget(question: question));
    }

    return widgets;
  }
}
