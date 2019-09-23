import 'package:flattereddoctors/model/survey.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SurveyInfoPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var survey = Provider.of<Survey>(context);

    if (survey == null)
      Navigator.pop(context);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              child: Column(
                children: <Widget>[
                  Text(survey.title, style: Theme.of(context).textTheme.display1),
                  Text("Umfrage erstellt von ${survey.author}", style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Theme.of(context).textTheme.body1.color.withAlpha(128)))
                ]
              ),
              padding: EdgeInsets.all(15)
            ),
            Expanded(
              child:  FloatingActionButton(
                child: Icon(Icons.play_arrow),
                tooltip: "Umfrage beginnen",
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, "/survey", (r) => false),
              )
            )

          ]
        )
      )
    );
  }

}