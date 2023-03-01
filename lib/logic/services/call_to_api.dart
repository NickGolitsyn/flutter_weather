import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:weather_app/constants/api_key.dart';

import '../models/weather_model.dart';

class CallToApi {
  Future<WeatherModel> callWeatherAPi(String cityName) async {
    try {
      var url = Uri.https('api.openweathermap.org', '/data/2.5/weather',
          {'q': cityName, "units": "metric", "appid": apiKey});
      final http.Response response = await http.get(url);
      // log(response.body.toString());
      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedJson = json.decode(response.body);
        final weather = WeatherModel.fromMap(decodedJson);
        final sunriseTime = weather.getSunriseTime();
        final sunsetTime = weather.getSunsetTime();
        return WeatherModel.fromMap(decodedJson);
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      throw Exception('Failed to load');
    }
  }
}