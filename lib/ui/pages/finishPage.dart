import 'package:flattereddoctors/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

class FinishPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text(currentSurvey.title),
          centerTitle: true,
          leading: IconButton( //Emuliert einen Back-Button da wir die Möglichkeit zurückzugehen entfernt haben.
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false),
          ),
          backgroundColor: Colors.green,
          elevation: 0,
      ),
      body: Container(
        color: Colors.green,
          padding: EdgeInsets.all(25),
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(16),
                    child: Icon(
                        Icons.check,
                        size: 72
                    ),
                ),
                Padding(
                    child: Text(
                        "Vielen Dank",
                        style: Theme.of(context).textTheme.display1
                    ),
                    padding: EdgeInsets.only(bottom: 8)
                ),
                Text(
                    "Du kannst diesen Fragenbogen mit deinen Freunden teilen!",
                    textAlign: TextAlign.center
                ),
                Row(
                  children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: RaisedButton.icon(
                            color: Colors.white,
                            textColor: Colors.green,
                            label: Text("QR-Code"),
                            icon: Icon(Mdi.qrcode),
                            onPressed: () {}, //TODO: QR-Code anzeigen
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: RaisedButton.icon(
                            color: Colors.white,
                            textColor: Colors.green,
                            label: Text("Teilen"),
                            icon: Icon(Mdi.shareVariant),
                            onPressed: () {}, //TODO: QR-Code anzeigen
                          ),
                        ),
                      ),
                  ],
                )
              ],
            ),
        )
    );
  }

}