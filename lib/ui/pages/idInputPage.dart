import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IdInputPage extends StatelessWidget {
  TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: Text("Code eingeben"),
          elevation: 0,
          backgroundColor: Colors.purple.shade500
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        color: Colors.purple.shade500,
        child: Center(
          child:
            Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.vpn_key),
                    hintText: "Umfrage-ID"
                  ),
                  controller: _controller,
                ),

                Align(
                  child: FlatButton(
                    child: Text("OK"),

                    onPressed: () => Navigator.pop(context, _controller.text),
                  ),
                  alignment: Alignment.bottomRight,
                )
              ],
            )
        ),
      )
    );
  }

}