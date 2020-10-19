import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:world_time_app/api/apikey.dart';
import 'dart:convert';

class weather extends StatefulWidget {
  @override
  _weatherState createState() => _weatherState();
}

class _weatherState extends State<weather> {

  var name;
  var temp;
  var des;
  var humidity;
  var wind;
  var current;

  var cityController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getweather();
  }

  Future getweather () async {
    http.Response response = await http.get("http://api.openweathermap.org/data/2.5/weather?q=garot,mp,in&units=imperial&appid=1f78ee0092129a42dc139ab310d83ede");
    var Res = jsonDecode(response.body);
    setState(() {
      this.temp = Res['main']['temp'];
      this.des = Res['weather'][0]['description'];
      this.current = Res['weather'][0]['main'];
      this.humidity = Res['main']['humidity'];
      this.wind = Res['wind']['speed'];
      this.name = Res['name'];
      temp = ((temp - 32)*5/9);
    });
  }


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.indigo,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                   name != null ? name.toString() : "loading",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  temp != null ? temp.toString().substring(0,5)+ "\u00B0C" : "Loading",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    current != null ? current.toString() : "Loading",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text("Temprature"),
                    trailing: Text(temp != null ? temp.toString().substring(0,5) + "\u00B0C" : "Loading",),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text("Description"),
                    trailing: Text(des != null ? des.toString() : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("Humidity"),
                    trailing: Text(humidity != null ? humidity.toString() : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Wind Speed"),
                    trailing: Text(wind != null ? wind.toString() : "Loading"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

