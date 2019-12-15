// 12.1 move imports from loading.dart for refactoring
import 'package:clima/services/location.dart'; // 5.5(a)
import 'package:clima/services/networking.dart'; //8.6(d)

const apiKey = 'b14228a38b603be1687a5109775fed6f'; // 8.1 & 12.3
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather'; //12.4

class WeatherModel {
  // 12.2 & 12.5
  Future<dynamic> getLocationWeather() async {
    Location loc = Location(); // 5.5(b)
    await loc.getCurrentLocation(); // 5.5(c)
    /*
    //print('longitude: ${loc.longitude}, latitude: ${loc.latitude}');

    // 8.3(b) & obsolete per 10.8(a)
    //latitude = loc.latitude;
    //longitude = loc.longitude;
    //print('lat:$latitude, long: $longitude');
    */

    // 8.6(e) & 10.8(a)
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${loc.latitude}&lon=${loc.longitude}&appid=$apiKey&units=metric'); // 10.5 use metric! & 12.4

    // 8.6(g)
    var weatherData = await networkHelper.getData();

    // 12.5
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
