import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart'; // 11.1
import 'city_screen.dart'; // 13.1(a)

class LocationScreen extends StatefulWidget {
  // 10.1 prop to receive data from loading_screen & constr
  final locationWeather;
  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  // 11.2
  WeatherModel weather = WeatherModel();
  // 10.4(b)
  int temperature; // 10.7 change double to int
  //int condition;  // OBSOLETE as per 11.4
  String weatherIcon; // 11.4
  String cityName;
  String weatherMessage; //11.7

  // 10.3
  @override
  void initState() {
    super.initState();
    //print(widget.locationWeather); // how to get data from parent stateful widget!
    updateUI(widget.locationWeather); // 10.4(d)
  }

  // 10.4(a) - use data from locationWeather and extract temp, id & city
  void updateUI(dynamic weatherData) {
    // 12.10 handle if location services don't work
    if (weatherData == null) {
      temperature = 0;
      weatherIcon = 'Error';
      weatherMessage = 'Unable to get weather data!';
      cityName = '';
      return; // ends method prematurely
    }
    // 11.8
    setState(() {
      // 7.5 & 8.6(f) & 8.7 & 10.4(c)
      temperature = weatherData['main']['temp'].toInt(); // 10.7 double -> int
      var condition = weatherData['weather'][0]['id']; // local as per 11.4 (added var)
      cityName = weatherData['name'];
      //print('the temperature of $cityName with the id of $condition is: $temperature°C!');

      weatherIcon = weather.getWeatherIcon(condition); // 11.3 & 11.5

      weatherMessage = weather.getMessage(temperature); // 11.7
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather(); //12.8
                      updateUI(weatherData); // 12.9
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    // 13.1(b) add Navigator.push() to push to city_screen
                    onPressed: () async {
                      // async is for receiving back data only , if one-way data, no need
                      // 14.2(b) to receive data from city_screen add var typedName
                      var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      // 14.4 get data from api for city typed in city_screen text field
                      if (typedName != null) {
                        var weatherData = await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°', // 10.6
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon', // 11.6
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityName', // 11.7 "" due to ' in getMessageText
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
