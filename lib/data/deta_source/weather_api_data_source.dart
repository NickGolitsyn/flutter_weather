import 'dart:convert';
import 'dart:developer';

import "package:http/http.dart" as http;
import 'package:weather_app/constants/api_key.dart';
import 'package:geolocator/geolocator.dart';

import '../models/weather_model.dart';

class WeatherApiDataSource {
  Future<WeatherModel> callWeatherAPi(String cityName) async {
    try {
      var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {'q': cityName, "units": "metric", "appid": apiKey});
      final http.Response response = await http.get(url);
      // log(response.body.toString());
      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedJson = json.decode(response.body);

        return WeatherModel.fromMap(decodedJson);
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      throw Exception('Failed to load');
    }
  }

  // Future<WeatherModel> callLocalWeatherAPi() async {
    // List<Placemark> placemarks = await placemarkFromCoordinates(
    //     currentPosition.latitude, currentPosition.longitude);

    // Placemark place = placemarks[0];
    // cityName = place.locality!;

    Future<Position> determinePosition() async {
      bool serviceEnabled;
      LocationPermission permission;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
      } 
      return await Geolocator.getCurrentPosition();
    }

    Future<WeatherModel> callLocalWeatherAPi() async {
      Position pos = await determinePosition();
      String latitude = pos.latitude.toString();
      String longitude = pos.longitude.toString();

      try {
        var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {'lat': latitude, 'lon': longitude, "units": "metric", "appid": apiKey});
        final http.Response response = await http.get(url);
        // log(response.body.toString());
        if (response.statusCode == 200) {
          final Map<String, dynamic> decodedJson = json.decode(response.body);

          return WeatherModel.fromMap(decodedJson);
        } else {
          throw Exception('Failed to load');
        }
      } catch (e) {
        throw Exception('Failed to load');
      }
    }
  // }
}
