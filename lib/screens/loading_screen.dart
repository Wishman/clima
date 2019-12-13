import 'package:flutter/material.dart';
import 'package:clima/services/location.dart'; // 5.5(a)

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

  void getLocation() async {
    Location loc = Location(); // 5.5(b)
    await loc.getCurrentLocation(); // 5.5(c)
    print('longitude: ${loc.longitude}, latitude: ${loc.latitude}');
  }

  @override
  Widget build(BuildContext context) {
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
    // 4.1(b) & (e)
    return Scaffold(
        body: Container(
      margin: EdgeInsets.all(myMarginAsDouble ?? 30.0), // 4.1(g)
      color: Colors.red,
    ));
  }
}
