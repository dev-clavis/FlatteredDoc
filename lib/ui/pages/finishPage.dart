import 'package:flutter/material.dart';

class FinishPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text("Flattered Doctors"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false),
          ),
          backgroundColor: Colors.green,
        elevation: 0  ,
      ),
      body: Container(
        color: Colors.green,
          padding: EdgeInsets.all(25),
            child: Column(
              children: <Widget>[
                Padding(child: Text("Vielen Dank", style: Theme.of(context).textTheme.display1), padding: EdgeInsets.only(bottom: 8)),
                Text("Du kannst diesen Fragenbogen mit deinen teilen!"),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        child: RaisedButton.icon(
                          icon: Icon(Icons.share),
                          label: Text("Teilen")
                        ),
                        padding: EdgeInsets.all(5)
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        child: RaisedButton.icon(
                            icon: Icon(Icons.camera_alt),
                            label: Text("QR-Code")
                        ),
                          padding: EdgeInsets.all(5)
                      ),
                    )
                  ],
                )
              ],
            ),
        )
    );
  }

}