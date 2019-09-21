import 'package:flattereddoctors/model/survey.dart';
import 'package:flattereddoctors/surveyPage.dart';
import 'package:flattereddoctors/ui/surveyInfoPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  var survey = Survey.testSurvey;
  runApp(ChangeNotifierProvider<Survey>(builder: (context) => survey, child:MyApp()));
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
      home: MyHomePage(),
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
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
              color: Colors.purple,
              textColor: Colors.white,
              icon: Icon(Icons.camera),
              label: Text("QR-Code scannen")
            ),

            RaisedButton.icon(
              textColor: Colors.white,
              color: Colors.purple,
              icon: Icon(Icons.text_fields),
              label: Text("Code eingeben")
            ),
            RaisedButton.icon(
              color: Colors.lightGreen,
              textColor: Colors.white,
              icon: Icon(Icons.bug_report),
              label: Text("Debug Button!"),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SurveyInfoPage())),
            ),
          ],
        ),
      )
      )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
