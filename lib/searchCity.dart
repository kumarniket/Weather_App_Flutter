import 'package:flutter/material.dart';
import 'package:weather_app_flutter/weather_screen.dart';

class SearchCity extends StatefulWidget {
  @override
  _SearchCityState createState() => _SearchCityState();
}

class _SearchCityState extends State<SearchCity> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController _cityControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search City'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: _cityControler, //input
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter City Name';
                  }
                },
                decoration: InputDecoration(
                    errorStyle: TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 8.0,
                    ),
                    labelText: 'City Name',
                    hintText: 'In India only',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
              ),
            ),
            RaisedButton(
              color: Colors.blue[200],
              child: Text(
                'Submit',
                textScaleFactor: 1.2,
              ),
              onPressed: () {
                debugPrint('submit clicked'); //button
                var router = MaterialPageRoute(
                  builder: (context) => WeatherScreen(
                    city: _cityControler.text,
                  ),
                );
                Navigator.of(context).push(router);
              },
            ),
          ],
        ),
      ),
    );
  }
}
