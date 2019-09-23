import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Über Flattered Doctors"),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: <Widget>[

          //Image.asset("icon.png"),
          Card(
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  ListTile(
                      leading: Icon(Mdi.githubCircle),
                      title: Text("GitHub Repository"),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () => {}, //TODO: Link zur GitHub Repo öffnen
                  ),
                  ListTile(
                      leading: Icon(Mdi.deleteEmpty),
                      title: Text("Erstellt für den PIT-Hackathon")
                  ),
                ],
              )
          )
        ],
      ),
    );
  }

}
