import 'package:flutter/material.dart';
import 'package:clima/services/location.dart'; // 5.5(a)
import 'package:http/http.dart' as http; // 6.2
import 'dart:convert'; //7.1

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // 3.2
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  // async / await needed to make sure data is actually here
  void getLocation() async {
    Location loc = Location(); // 5.5(b)
    await loc.getCurrentLocation(); // 5.5(c)
    print('longitude: ${loc.longitude}, latitude: ${loc.latitude}');
  }

  // 6.3 - use APi version that accepts lat & long
  void getData() async {
    http.Response response = await http.get('https://samples.openweathermap.org/data/2'
        '.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22');

    if (response.statusCode == 200) {
      String data = response.body;
      //print(data);

      /* 7.4
      var longitude = jsonDecode(data)['coord']['lon']; //7.2
      print(longitude);

      // 7.3
      var weatherDescription = jsonDecode(data)['weather'][0]['description'];
      print(weatherDescription);
      */

      // 7.5
      var temperature = jsonDecode(data)['main']['temp'];
      var condition = jsonDecode(data)['weather'][0]['id'];
      var cityName = jsonDecode(data)['name'];
      print('the temperature of $cityName with the id of $condition is: $temperature Degrees!');
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    /* old stuff
    // 4.1(a) & (e)
    String myMargin = 'abc';
    double myMarginAsDouble;

    // 4.1(c) & (e)
    try {
      myMarginAsDouble = double.parse(myMargin);
    }
    // 4.1 (d)
    catch (e) {
      //myMarginAsDouble = 30.0;  // not needed due to 4.1(g)
      //print(e);
      // 4.1 (f) - on error, provide default value
    }
    */
    getData(); //6.3

    // 4.1(b) & (e)
    return Scaffold();
  }
}
