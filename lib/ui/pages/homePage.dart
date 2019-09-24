import 'package:flattereddoctors/api/FlatteredDoctorsApi.dart';
import 'package:flattereddoctors/main.dart';
import 'package:flattereddoctors/model/survey.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';
import 'package:qr_utils/qr_utils.dart';



class HomePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  _HomePageState createState() => _HomePageState(_scaffoldKey);
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey;
  bool isLoading = false;

  _HomePageState([this._scaffoldKey]);

  @override
  Widget build(BuildContext context) {
    Widget getErrorSnackBar(String text) => SnackBar(
        content: Row(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(right: 12), child: Icon(Icons.error)),
            Text(text)
          ],
        )
    );

    void tryToEnterSurvey(BuildContext context, int surveyId, GlobalKey<ScaffoldState> key) async {
      try {
        setState(() => isLoading = true);
        var questionCount = await FlatteredDoctorsApi.wasAnsweredBefore(deviceId, surveyId);

        if (questionCount == null) {
          key.currentState.showSnackBar(getErrorSnackBar('Der Server kann derzeit nicht\nvalidieren ob du schon teilgenommen hast.'));
        } else if (questionCount > 0) {
          key.currentState.showSnackBar(getErrorSnackBar('Du kannst nicht an einer Umfrage\n nicht noch mal teilnehmen!'));
        } else {
          var newSurvey = await FlatteredDoctorsApi.getSurvey(surveyId);
          Provider.of<Survey>(context).copyFrom(newSurvey);
          Navigator.pushNamed(context, "/survey/info");
        }
      } catch (ex) {
        key.currentState.showSnackBar( getErrorSnackBar('Es ist ein Fehler aufgetreten die \nUmfrage abzurufen.'));
      } finally {
        setState(() => isLoading = false);
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Flattered Doctors"),
          centerTitle: true,
        ),
        key: _scaffoldKey,
        body: Container(
            color: Colors.purple.shade300,
            padding: EdgeInsets.all(30),
            child: Center(
                child: isLoading ?
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                strokeWidth: 4
                            ),
                        ),
                        Text("Warte auf Server...")
                    ],
                ) :
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          "Willkommen",
                          style: Theme.of(context).textTheme.display1
                      ),
                      Padding(
                          padding: EdgeInsets.only(top:8),
                          child: Text("wie möchtest Du eine Umfrage finden?", style: Theme.of(context).textTheme.body1)
                      ),
                      Divider(height: 60),
                      RaisedButton.icon(
                          color: Colors.white,
                          textColor: Colors.purple,
                          icon: Icon(Mdi.qrcode),
                          label: Text("QR-Code scannen"),
                          onPressed: () => QrUtils.scanQR.then((s) {
                            var id = int.tryParse(s);

                            if (id == null)
                              _scaffoldKey.currentState.showSnackBar(getErrorSnackBar('Ungültiger QR-Code'));
                            else
                              tryToEnterSurvey(context, id, _scaffoldKey);
                          })
                      ),
                      RaisedButton.icon(
                          color: Colors.white,
                          textColor: Colors.purple,
                          icon: Icon(Mdi.formatTextVariant),
                          label: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 9),
                              child: Text("Code eingeben")
                          ),
                          onPressed: () => Navigator.pushNamed(context, "/inputId").then((id) {
                            if (id == null)
                              return;

                            tryToEnterSurvey(context, id, _scaffoldKey);
                          })
                      )
                    ],
                ),
            )
        ),
        bottomNavigationBar: Container(
            color: Colors.purple.shade300,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.person),
                        tooltip: "Account",
                      )
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.bug_report),
                      tooltip: "Debug",
                      onPressed: () => Navigator.pushNamed(context, '/debug')
                    ),
                    IconButton(
                        icon: Icon(Icons.info),
                        tooltip: "Über diese App",
                        onPressed: () => Navigator.pushNamed(context, '/about')
                    )
                  ],
                )
              ],
            ),
        ),
    );
  }
}
