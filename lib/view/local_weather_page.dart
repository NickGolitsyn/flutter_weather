import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather_app/data/models/enums/city_enum.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/data/deta_source/weather_api_data_source.dart';

class LocalWeatherPage extends StatefulWidget {
  const LocalWeatherPage({super.key});

  @override
  State<LocalWeatherPage> createState() => _LocalWeatherPageState();
}

class _LocalWeatherPageState extends State<LocalWeatherPage> {
  Future<WeatherModel> getData() async {
    return await WeatherApiDataSource().callLocalWeatherAPi();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FutureBuilder<WeatherModel>(
                  future: getData(),
                  builder: (ctx, AsyncSnapshot<WeatherModel> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network("http://openweathermap.org/img/wn/${snapshot.data!.icon}@2x.png"),
                              Text(
                                snapshot.data!.city,
                                style: const TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        "Sunrise",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.getSunriseTime(),
                                        // "${new Date(data.sunrise*1000)}",
                                        style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        "Sunset",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.getSunsetTime(),
                                        // "${new Date(data.sunrise*1000)}",
                                        style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Text(
                                snapshot.data!.desc,
                                style: const TextStyle(color: Colors.black, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Text(
                                "${snapshot.data!.temp}°C",
                                style: const TextStyle(fontSize: 42, color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        );
                      }
                    } else if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return const Center(
                      child: Text("Error"),
                    );
                  },
                ),
                SizedBox(
                  height: 300,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
