import 'package:flattereddoctors/model/question.dart';
import 'package:flattereddoctors/model/questionType.dart';
import 'package:flattereddoctors/model/survey.dart';
import 'package:flattereddoctors/ui/widgets/optionWidget.dart';
import 'package:flattereddoctors/ui/widgets/questionWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SurveyPage extends StatelessWidget {
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    bool lastQuestion = isLastQuestion(Provider.of<Survey>(context));
    return Consumer<Survey>(
        builder: (context, survey, child) => Scaffold(
            appBar: AppBar(
                title: Text(survey.title),
                centerTitle: true,
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                    child: PageView(
                  controller: _pageController,
                  children: getQuestionPages(Survey.testSurvey),
                  physics: NeverScrollableScrollPhysics(),
                  onPageChanged: (ni) {
                    var survey = Provider.of<Survey>(context);
                    survey.onQuestion(getCurrentQuestion(survey));
                  },
                )),
                Padding(
                    padding:
                        EdgeInsets.only(left: 5, right: 10, top: 5, bottom: 5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Tooltip(
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                        padding:
                                            EdgeInsets.only(left: 8, right: 16),
                                        child: Stack(
                                          children: <Widget>[
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 6, top: 6),
                                                child:
                                                    Icon(Icons.flag, size: 24)),
                                            CircularProgressIndicator(
                                              value: (getCurrentPage() + 1) /
                                                  survey.questions.length,
                                            )
                                          ],
                                        )),
                                    Text(
                                        "Frage ${getCurrentPage() + 1} von ${survey.questions.length}",
                                        textAlign: TextAlign.left)
                                  ],
                                ),
                                message: "Vorschritt des Fragebogens")),
                        RaisedButton.icon(
                            label: Text(lastQuestion ? "Abschließen" : "Weiter"),
                            icon: Icon(lastQuestion ? Icons.check : Icons.arrow_forward),
                            onPressed: () {
                              if(lastQuestion) {
                                Navigator.pushNamed(context, "/finish");
                              } else {
                                _pageController.jumpToPage(getCurrentPage() + 1);
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24))))
                      ],
                    ))
              ],
            )));
  }

  /// Ruft den (gerundeten) derzeitigen Index des PageControllers ab. Returnt 0 wenn PageController failt.
  int getCurrentPage() {
    try {
      return _pageController.page.round();
    } catch (Exception) {
      return 0;
    }
  }

  /// Prüft ob der User bei der letzten Frage ist.
  bool isLastQuestion(Survey survey) => survey.questions.last == getCurrentQuestion(survey);

  /// Ruft die jetzige Frage ab
  Question getCurrentQuestion(Survey survey) => survey.questions[getCurrentPage()];

  /// Generiert Widget-Seiten für die Fragen.
  List<Widget> getQuestionPages(Survey survey) {
    var widgets = List<Widget>();

    for (var question in survey.questions) {
      widgets.add(QuestionWidget(question: question));
    }

    return widgets;
  }

  Widget getLoadingWidget() => Center(child: CircularProgressIndicator());
}
