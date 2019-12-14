// 8.6
import 'package:http/http.dart' as http; // 6.2
import 'dart:convert'; //7.1

// 8.6(b)
class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  // 8.6(h)
  Future<void> getData() async {
    http.Response response = await http.get(url); // 8.2 & 8.4

    if (response.statusCode == 200) {
      // 8.6(i) return decoded json response
      return jsonDecode(response.body);

      /* 7.4
      var longitude = jsonDecode(data)['coord']['lon']; //7.2
      print(longitude);

      // 7.3
      var weatherDescription = jsonDecode(data)['weather'][0]['description'];
      print(weatherDescription);
      */

    } else {
      print(response.statusCode);
    }
  }
}
