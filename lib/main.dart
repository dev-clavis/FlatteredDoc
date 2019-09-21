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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.purpleAccent.shade700,
        brightness: Brightness.dark
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
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flattered Doctors"),
        backgroundColor: Colors.purple.shade500,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
          color: Colors.purple.shade500,
          padding: EdgeInsets.all(30),
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Willkommen", style: Theme.of(context).textTheme.display1),
            Padding(
              padding: EdgeInsets.only(top:8),
              child: Text("wie möchtest Du eine Umfrage finden?", style: Theme.of(context).textTheme.body1)
            )
            ,

            Divider(height: 60),

            RaisedButton.icon(
              color: Colors.white,
              textColor: Colors.purple,
              icon: Icon(Icons.camera),
              label: Text("QR-Code scannen"),
              onPressed: () => QrUtils.scanQR.then((s) {
                if (s == null)
                  return;
                else
                  tryToEnterSurvey(context, s);
              })
            ),

            RaisedButton.icon(
              textColor: Colors.purple,
              color: Colors.white,
              icon: Icon(Icons.text_fields),
              label: Text("Code eingeben"),
                onPressed: () => Navigator.pushNamed(context, "/inputId").then((id) {
                  if ((id as String).isEmpty)
                    return;
                  else
                    tryToEnterSurvey(context, id);
                })
            ),
            //RaisedButton.icon(
            //  color: Colors.lightGreen,
            //  textColor: Colors.white,
            //  icon: Icon(Icons.bug_report),
            ////  label: Text("Debug Button!"),
            //  onPressed: () => Navigator.push(context,
            //      MaterialPageRoute(builder: (context) => SurveyInfoPage())),
            //),
          ],
        ),
      )
      )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void tryToEnterSurvey(BuildContext context, String id) {
    try {
      FlatteredDoctorsApi.getSurvey(int.parse(id)).then((newSurvey) {
        Provider.of<Survey>(context).copyFrom(newSurvey);
        Navigator.pushNamed(context, "/surveyInfo");
      });
    } catch (ex) {
      final snackBar = SnackBar(
          content: Row(
            children: <Widget>[
              Icon(Icons.error),
              Text('Es ist ein Fehler aufgetreten die Umfrage abzurufen.')
            ],
          )
      );

      Scaffold.of(context).showSnackBar(snackBar);

      print("Exception beim Laden vom QR-Code wurde behandelt: " + ex.toString());
    }

  }
}
