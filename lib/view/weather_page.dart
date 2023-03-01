import 'package:flutter/material.dart';
import 'package:weather_app/data/models/enums/city_enum.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/data/deta_source/weather_api_data_source.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Future<WeatherModel> getData(CityEnum cityName) async {
    return await WeatherApiDataSource().callWeatherAPi(cityName.cityString);
  }

  CityEnum cityName = CityEnum.moscow;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Погода'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: InkWell(
                    onTap: () => setState(() {
                      cityName = CityEnum.moscow;
                    }),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(6), bottomLeft: Radius.circular(6)),
                        color: Color.fromARGB(255, 199, 199, 199),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Align(
                          child: Text(
                            'Moscow',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => setState(() {
                    cityName = CityEnum.paris;
                  }),
                  child: Container(
                    color: const Color.fromARGB(255, 199, 199, 199),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Align(
                        child: Text(
                          'Paris',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => setState(() {
                    cityName = CityEnum.newyork;
                  }),
                  child: Container(
                    color: const Color.fromARGB(255, 199, 199, 199),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Align(
                        child: Text(
                          'New York',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: InkWell(
                    onTap: () => setState(() {
                      cityName = CityEnum.london;
                    }),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(6), bottomRight: Radius.circular(6)),
                        color: Color.fromARGB(255, 199, 199, 199),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Align(
                          child: Text(
                            'London',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          FutureBuilder<WeatherModel>(
            future: getData(cityName),
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
        ],
      ),
    );
  }
}
