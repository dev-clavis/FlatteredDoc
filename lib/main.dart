import 'package:flattereddoctors/api/FlatteredDoctorsApi.dart';
import 'package:flattereddoctors/model/survey.dart';
import 'package:flattereddoctors/ui/pages/finishPage.dart';
import 'package:flattereddoctors/ui/pages/idInputPage.dart';
import 'package:flattereddoctors/ui/pages/surveyPage.dart';
import 'package:flattereddoctors/ui/pages/surveyInfoPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_utils/qr_utils.dart';
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

class MyHomePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  _MyHomePageState createState() => _MyHomePageState(_scaffoldKey);
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey;

  _MyHomePageState([this._scaffoldKey]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flattered Doctors"),
        backgroundColor: Colors.purple,
        //elevation: 1,
        centerTitle: true,
      ),
      key: _scaffoldKey,
      body: Container(
          color: Colors.purple.shade300,
          padding: EdgeInsets.all(30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Willkommen", style: Theme.of(context).textTheme.display1),
                Padding(
                  padding: EdgeInsets.only(top:8),
                  child: Text("wie möchtest Du eine Umfrage finden?", style: Theme.of(context).textTheme.body1)
                ),

                Divider(height: 60),

                RaisedButton.icon(
                  color: Colors.white,
                  textColor: Colors.purple,
                  icon: Icon(Icons.camera_alt),
                  label: Text("QR-Code scannen"),
                  onPressed: () => QrUtils.scanQR.then((s) {
                    if (s == null)
                      return;
                    else
                      tryToEnterSurvey(context, s,_scaffoldKey);
                  })
                ),
                RaisedButton.icon(
                  textColor: Colors.purple,
                  color: Colors.white,
                  icon: Icon(Icons.text_fields),
                  label: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 9),
                      child: Text("Code eingeben")
                  ),
                  onPressed: () => Navigator.pushNamed(context, "/inputId").then((id) {
                    if ((id as String).isEmpty)
                      return;
                    else
                      tryToEnterSurvey(context, id, _scaffoldKey);
                  })
                )
            ],
          ),
        )
      )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void tryToEnterSurvey(BuildContext context, String id, GlobalKey<ScaffoldState> key) async {
    try {
      var surveyId = int.parse(id);

      var questionCount = await FlatteredDoctorsApi.wasAnsweredBefore(deviceId, surveyId);

      if (questionCount == null) {
        key.currentState.showSnackBar( getErrorSnackBar('Der Server kann derzeit nicht\nvalidieren ob du schon teilgenommen hast.'));
      } else if (questionCount > 0) {
        key.currentState.showSnackBar( getErrorSnackBar('Du kannst nicht an einer Umfrage\n nicht noch mal teilnehmen!'));
      } else {
        var newSurvey = await FlatteredDoctorsApi.getSurvey(surveyId);
        Provider.of<Survey>(context).copyFrom(newSurvey);
        Navigator.pushNamed(context, "/surveyInfo");
      }


    } catch (ex) {
      print("Exception beim Laden vom QR-Code wurde behandelt: " + ex.toString());
      key.currentState.showSnackBar( getErrorSnackBar('Es ist ein Fehler aufgetreten die \nUmfrage abzurufen.'));

    }

  }

  Widget getErrorSnackBar(String text) => SnackBar(
      content: Row(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(right: 12), child: Icon(Icons.error)),
          Text(text)
        ],
      )
  );
}
