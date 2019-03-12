import 'package:flutter/material.dart';

class Klimatic extends StatefulWidget {
  final Widget child;

  Klimatic({Key key, this.child}) : super(key: key);

  _KlimaticState createState() => _KlimaticState();
}

class _KlimaticState extends State<Klimatic> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("Klimatic"),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.menu),
            onPressed: null,
          )
        ],
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset('images/umbrella.png',
            width: 490.0,
            height: 1200.0,
            fit: BoxFit.fill,
            ),

          ),
          new Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.fromLTRB(0.0, 11, 21, 0),
            child: new Text("Ahmedabad",
              style: cityStyle(),
            ),
          )
        ],
      ),
    );
  }
}

TextStyle cityStyle(){
  return new TextStyle(
    color: Colors.white,
    fontSize: 23,
    fontStyle: FontStyle.italic
  );
}