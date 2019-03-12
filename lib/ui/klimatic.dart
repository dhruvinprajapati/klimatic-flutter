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
        backgroundColor: Colors.black,
        actions: <Widget>[],
      ),
    );
  }
}