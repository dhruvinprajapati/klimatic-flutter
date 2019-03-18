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
  String _cityupdate;
  Future _goToNextScreen(BuildContext context) async{
    Map results = await Navigator.of(context).push(
      new MaterialPageRoute<Map>(builder: (BuildContext context){
        return new changeCity();
      })
    );
    if(results != null && results.containsKey('enter'))
    {
      _cityupdate = results['enter'];
      // print(results['enter'].toString());
    }
  }

  void showStuff() async{
    Map data = await  getWeather(util.apiId, util.defaultCity);
    //print(data.toString());
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
            onPressed: () {_goToNextScreen(context);},
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
            child: new Text('$_cityupdate',
              style: cityStyle(),
            ),
          ),
          new Container(
            alignment: Alignment.center,
            child: new Image.asset('images/light_rain.png'),
          ),
          new Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(50, 390, 0,0),
            child: updateTempWidget(_cityupdate),
            //new Text("67.00f",style: tempStyle(),)
          )
        ],
      ),
    );
  }
  Future<Map> getWeather(String apiId,String city) async {
    String apiurl = 'http://api.openweathermap.org/data/2.5/weather?q=$city&APPID=${util.apiId}&units=metric';
    http.Response response =await http.get(apiurl);
    return json.decode(response.body);
  }
  Widget updateTempWidget(String city){
    return new FutureBuilder(
      future: getWeather(util.apiId, city == null ? util.defaultCity :city),
      builder: (BuildContext context,AsyncSnapshot<Map> snapshot){
        if(snapshot.hasData){
          Map content =snapshot.data;
          return new Container(
            child: new Column(
              children: <Widget>[
                new ListTile(
                  title: new Text(content['main']['temp'].toString()+"C",
                  style: tempStyle(),),
                  subtitle: new ListTile(
                    title: new Text("Humidity: ${content['main']['humidity'].toString()} \n ""min: ${content['main']['temp_min'].toString()} \n"" max: ${content['main']['temp_max'].toString()}\n",style: new TextStyle(color: Colors.white),),
                  ),
                )
              ],
            ),
          );
        }
        else{
          return new Container();
        }
    });
  }
}

class changeCity extends StatelessWidget {
  var _cityFieldController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: new Text("City"),
          backgroundColor: Colors.red,
          centerTitle: true,
        ),
        body: new Stack(
          children: <Widget>[
            new Center(
              child: new Image.asset('images/white_snow.png',width: 500,height: 1200,fit: BoxFit.fill,),
            ),

            new ListView(
              children: <Widget>[
                new ListTile(
                  title: new TextField(
                    decoration: new InputDecoration(
                      hintText: 'Enter City'
                    ),
                    controller: _cityFieldController,
                    keyboardType: TextInputType.text,
                  ),
                ),
                new ListTile(
                  title: new FlatButton(
                    onPressed: () {
                      Navigator.pop(context,{
                        'enter':_cityFieldController.text,
                      });
                    },
                    textColor: Colors.black,
                    child: new Text("get the wether"),
                  ),
                )
              ],
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
TextStyle tempStyle(){
  return new TextStyle(
    color: Colors.white,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    fontSize: 50
  );
}