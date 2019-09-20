import 'package:flutter/material.dart';

class QuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Quiz numba 1")),
      body: Padding(
        padding: EdgeInsets.all(30),
          child:Column(
        children: <Widget>[
          Text("Welcher Anime gehört in die Mülltonne?", style: Theme.of(context).textTheme.display2),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.purpleAccent
            ),
            child: Row(

              children: <Widget>[

                Radio(
                  value: true,

                  onChanged: (v) {},
                  children: <Widget>[
                                      ]
                ),
                Text("Eromanga Sensei")

              ],
            ),
          )
        ],
      )
    ));
  }

}