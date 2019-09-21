import 'package:flattereddoctors/model/survey.dart';
import 'package:flattereddoctors/surveyPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SurveyInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              child: Consumer<Survey>(
              builder: (context, survey, child) => Text(survey.title, style: Theme.of(context).textTheme.display1)),
              padding: EdgeInsets.all(15)
            ),
            Expanded(
              child:  FloatingActionButton(
                child: Icon(Icons.play_arrow),
                tooltip: "Umfrage beginnen",
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SurveyPage())),
              )
            )

          ]
        )
      )
    );
  }

}