import 'package:flutter/material.dart';
import 'package:clima/services/location.dart'; // 5.5(a)
import 'package:clima/services/networking.dart'; //8.6(d)

const apiKey = 'b14228a38b603be1687a5109775fed6f'; // 8.1

// 8.3(a)
double latitude;
double longitude;

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
  // 8.6(c)
  void getLocationData() async {
    Location loc = Location(); // 5.5(b)
    await loc.getCurrentLocation(); // 5.5(c)

    //print('longitude: ${loc.longitude}, latitude: ${loc.latitude}');

    // 8.3(b)
    latitude = loc.latitude;
    longitude = loc.longitude;

    // 8.6(e)
    NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap.org/data/2'
        '.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');

    // 8.6(g)
    var weatherData = await networkHelper.getData();

    //getData(); //6.3 & 8.5
  }

  // 6.3 - use APi version that accepts lat & long
  // void getData() async {}  // no longer needed with 8.6(f)

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

    // 4.1(b) & (e)
    return Scaffold();
  }
}
