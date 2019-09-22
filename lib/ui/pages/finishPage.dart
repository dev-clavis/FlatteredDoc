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
                Padding(padding: EdgeInsets.all(16), child: Icon(Icons.check_circle)),
                Padding(child: Text("Vielen Dank", style: Theme.of(context).textTheme.display1), padding: EdgeInsets.only(bottom: 8)),
                Text("Du kannst diesen Fragenbogen mit deinen Freunden teilen!"),
                Row(
                  children: <Widget>[

                  ],
                )
              ],
            ),
        )
    );
  }

}