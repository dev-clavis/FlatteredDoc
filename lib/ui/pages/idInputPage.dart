import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IdInputPage extends StatefulWidget {
  @override
  _IdInputPageState createState() => _IdInputPageState();
}

class _IdInputPageState extends State<IdInputPage> {
  TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    int validate() {
      if (_controller.text.isEmpty) {
        return 1;
      } else if (int.tryParse(_controller.text) == null) {
        return 2;
      } else {
        return 0;
      }
    }

    int validationCode = validate();

    void finish() {
      if(validationCode == 0)
        Navigator.pop(context, int.parse(_controller.text));
    }

    String getValidationText(int code) {
      switch (code) {
        case 1: return "Die Eingabe ist leer";
        case 2: return "Die Eingabe muss eine Nummer sein";
        default: return null;
      }
    }
    
    return Scaffold(
        appBar: AppBar(
            title: Text("Code eingeben"),
            backgroundColor: Colors.purple.shade500
        ),
        body: Container(
            padding: EdgeInsets.all(30),
            //color: Colors.purple.shade300,
            child: Center(
              child:
                Column(
                  children: <Widget>[
                    TextField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.vpn_key),
                          hintText: "Umfrage-ID",
                          errorText: getValidationText(validationCode)
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        autocorrect: false,
                        onChanged: (_) => setState(() {}), //Page updaten dass die Fehlermeldung erscheint.
                        onSubmitted: (_) => finish(),
                        controller: _controller,
                    ),

                    Align(
                        child: FlatButton(
                            child: Text("OK"),
                            onPressed: validationCode == 0 ? (() => finish()) : null
                        ),
                        alignment: Alignment.bottomRight,
                    )
                ])
            ),
        )
    );
  }
}