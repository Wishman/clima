import 'package:flutter/material.dart';
import 'location_screen.dart'; // 9.1
import 'package:flutter_spinkit/flutter_spinkit.dart'; // 9.2(b)
import 'package:clima/services/weather.dart'; // 12.6

// 8.3(a) & obsolete as per 10.8(a)
//double latitude;
//double longitude;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // 3.2
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  // async / await needed to make sure data is actually here
  // 8.6(c)
  void getLocationData() async {
    // 12.7 - short version
    var weatherData = await WeatherModel().getLocationWeather();

    // 9.1 - setup route to location_screen
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeather: weatherData);
    }));
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
    return Scaffold(
      // 9.2(c)
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
