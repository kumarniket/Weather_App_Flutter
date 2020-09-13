import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class WeatherScreen extends StatefulWidget {
  final String city;
  WeatherScreen({this.city});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;
  var name;

  Future getWeather(String city) async {
    http.Response response = await http.get(
        'http://api.openweathermap.org/data/2.5/weather?q=$city&units=imperial&appid=24e81755f4b617ad2ba18fca8f9f1312');
    if (response.statusCode != 200) throw Exception();

    var result = jsonDecode(response.body);
    setState(() {
      this.temp = result['main']['temp'];
      this.description = result['weather'][0]['description'];
      this.currently = result['weather'][0]['main'];
      this.humidity = result['main']['humidity'];
      this.windSpeed = result['wind']['speed'];
      this.name = result['name'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather(widget.city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue[200],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Currently in ${name.toString()}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + "\u2109" : "Loading",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    currently != null ? currently.toString() : "Loading",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
                padding: EdgeInsets.all(20),
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                      title: Text('Temperature'),
                      trailing: Text(temp != null
                          ? temp.toString() + "\u2109"
                          : "Loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.cloud),
                      title: Text('Weather'),
                      trailing: Text(description != null
                          ? description.toString()
                          : "Loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.sun),
                      title: Text('Humidity'),
                      trailing: Text(
                          humidity != null ? humidity.toString() : "Loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.wind),
                      title: Text('Wind Speed'),
                      trailing: Text(
                          windSpeed != null ? windSpeed.toString() + "km/h" : "Loading"),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
