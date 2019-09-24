import 'package:flattereddoctors/model/survey.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class DebugPage extends StatefulWidget {
  @override
  _DebugPageState createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Debug"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            tooltip: "Werte neuladen",
            onPressed: () => setState(() {}),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Mdi.phone),
            title: Text("Device/User ID"),
            subtitle: Text(deviceId),
          ),
          ListTile(
            leading: Icon(Mdi.viewList),
            title: Text("Current survey"),
            subtitle: Text("Id: ${currentSurvey.id}, ${currentSurvey.questions.length} questions"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Mdi.function),
            title: Text("Finish Page öffnen"),
            onTap: () => Navigator.pushNamed(context, '/survey/finish')
          ),
          ListTile(
              leading: Icon(Mdi.function),
              title: Text("Lokale Debug Umfrage starten"),
              onTap: () {
                Provider.of<Survey>(context).copyFrom(Survey.testSurvey);
                Navigator.pushNamed(context, '/survey/info');
              }
          )
        ],
      )
    );
  }
}