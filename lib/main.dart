import 'package:flattereddoctors/model/survey.dart';
import 'package:flattereddoctors/ui/pages/finishPage.dart';
import 'package:flattereddoctors/ui/pages/homePage.dart';
import 'package:flattereddoctors/ui/pages/idInputPage.dart';
import 'package:flattereddoctors/ui/pages/surveyPage.dart';
import 'package:flattereddoctors/ui/pages/surveyInfoPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unique_identifier/unique_identifier.dart';

Survey currentSurvey = Survey.testSurvey;
String deviceId;

void main() async {
  deviceId = await UniqueIdentifier.serial;
  runApp(ChangeNotifierProvider<Survey>(builder: (context) => currentSurvey, child:MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flattered Doctors',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.purpleAccent,
        brightness: Brightness.dark,
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          hoverColor: Colors.white,
          focusColor: Colors.white
        )
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/surveyInfo': (context) => SurveyInfoPage(),
        '/survey': (context) => SurveyPage(),
        '/inputId': (context) => IdInputPage(),
        '/finish': (context) => FinishPage()
      },
    );
  }
}