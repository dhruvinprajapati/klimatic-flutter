import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import '../util/utils.dart' as util;
import 'package:http/http.dart' as http;


class Klimatic extends StatefulWidget {
  final Widget child;

  Klimatic({Key key, this.child}) : super(key: key);

  _KlimaticState createState() => _KlimaticState();
}

class _KlimaticState extends State<Klimatic> {

  void showStuff() async{
    Map data = await  getWeather(util.apiId, util.defaultCity);
    print(data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("Klimatic"),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.menu),
            onPressed: showStuff,
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
          ),
          new Container(
            alignment: Alignment.center,
            child: new Image.asset('images/light_rain.png'),
          ),
          new Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(30, 210, 0,0),
            child: new Text("67.00f",style: tempStyle(),),
          )
        ],
      ),
    );
  }
  Future<Map> getWeather(String apiId,String city) async {
    // String apiurl = 'https://samples.openweathermap.org/data/2.5/weather?q=$city&APPID=${util.apiId}';
    String apiurl = 'http://api.openweathermap.org/data/2.5/weather?q=$city&APPID=${util.apiId}&units=imperial';
    http.Response response =await http.get(apiurl);
    return json.decode(response.body);
  }
}

TextStyle cityStyle(){
  return new TextStyle(
    color: Colors.white,
    fontSize: 23,
    fontStyle: FontStyle.italic
  );
}
TextStyle tempStyle(){
  return new TextStyle(
    color: Colors.white,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    fontSize: 50
  );
}