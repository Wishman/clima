import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart'; // 1.1

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

  // 1.2
  void getLocation() async {
    // 4.2 - getLocation() might fail, as user denies permission, gps not available, location unknown, etc.
    try {
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low); // 1.3
      print(position);
    } catch (e) {
      print(e);
    }
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
      print(e);
      // 4.1 (f) - on error, provide default value
      //myMarginAsDouble = 30.0;  // not needed due to 4.1(g)
    }
    // 4.1(b) & (e)
    return Scaffold(
        body: Container(
      margin: EdgeInsets.all(myMarginAsDouble ?? 30.0), // 4.1(g)
      color: Colors.red,
    ));
  }
}
