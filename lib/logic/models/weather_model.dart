class WeatherModel {
  final String temp;
  final String city;
  final String desc;
  final String icon;
  final int sunrise;
  final int sunset;

  WeatherModel.fromMap(Map<String, dynamic> json)
      : temp = json['main']['temp'].toString(),
        city = json['name'],
        desc = json['weather'][0]['description'],
        icon = json['weather'][0]['icon'],
        sunrise = json['sys']['sunrise'],
        sunset = json['sys']['sunset'];

  DateTime getSunriseTime() {
    return DateTime.fromMillisecondsSinceEpoch(sunrise * 1000);
  }

  DateTime getSunsetTime() {
    return DateTime.fromMillisecondsSinceEpoch(sunset * 1000);
  }
}