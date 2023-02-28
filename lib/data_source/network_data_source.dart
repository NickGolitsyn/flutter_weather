import 'package:http/http.dart' as http;
import 'package:weather_app/constants/api_key.dart';

class Example {
  Future<void> makeRequest() async {
    Uri url = Uri.https('api.openweathermap.org', '/data/2.5/weather', 
      {'q': 'London', "units": "metric", "appid": apiKey});

    // http.Response response;
    final http.Response response = await http.get(url);

    //* Нужно сделть приложение которое будет показывать какая погода в Москве, Париже, Ньюйорке.
    print('hi');
    print(response);
  }
}