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

  String getSunriseTime() {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(sunrise * 1000);

    String hour = dateTime.hour < 10 ? '0${dateTime.hour}' : '${dateTime.hour}';
    String minute = dateTime.minute < 10 ? '0${dateTime.minute}' : '${dateTime.minute}';
    return '$hour:$minute';
  }

  String getSunsetTime() {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(sunset * 1000);

    String hour = dateTime.hour < 10 ? '0${dateTime.hour}' : '${dateTime.hour}';
    String minute = dateTime.minute < 10 ? '0${dateTime.minute}' : '${dateTime.minute}';
    return '$hour:$minute';
  }
}
