import 'dart:developer';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weather_app/logic/models/weather_model.dart';
import 'package:weather_app/logic/services/call_to_api.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Future<WeatherModel> getData(bool isCurrentCity, String cityName) async {
    return await CallToApi().callWeatherAPi(isCurrentCity, cityName);
  }

  TextEditingController textController = TextEditingController(text: "");
  Future<WeatherModel>? _myData;
  @override
  void initState() {
    setState(() {
      _myData = getData(true, "London");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: FutureBuilder(
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If error occured
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error.toString()} occurred',
                  style: TextStyle(fontSize: 18),
                ),
              );

              // if data has no errors
            } else if (snapshot.hasData) {
              // Extracting data from snapshot object
              final data = snapshot.data as WeatherModel;
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                width: double.infinity,
                height: double.infinity,
                child: SafeArea(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: InkWell(
                                onTap: () => setState(() {
                                  _myData = getData(false, 'Moscow');
                                }),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(6), bottomLeft: Radius.circular(6)),
                                    color: Color.fromARGB(255, 199, 199, 199),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    child: Align(
                                      child: Text(
                                        'Moscow',
                                        // style: TextStyle(
                                        //   color: priority != Priority.high ? Colors.black : Colors.white,
                                        // ),
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
                                _myData = getData(false, 'Paris');
                              }),
                              child: Container(
                                color: Color.fromARGB(255, 199, 199, 199),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: Align(
                                    child: Text(
                                      'Paris',
                                      // style: TextStyle(
                                      //   color: priority != Priority.medium ? Colors.black : Colors.white,
                                      // ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () => setState(() {
                                _myData = getData(false, 'New York');
                              }),
                              child: Container(
                                color: Color.fromARGB(255, 199, 199, 199),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: Align(
                                    child: Text(
                                      'New York',
                                      // style: TextStyle(
                                      //   color: priority != Priority.low ? Colors.black : Colors.white,
                                      // ),
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
                                  _myData = getData(false, 'London');
                                }),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(6), bottomRight: Radius.circular(6)),
                                    color: Color.fromARGB(255, 199, 199, 199),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    child: Align(
                                      child: Text(
                                        'London',
                                        // style: TextStyle(
                                        //   color: priority != Priority.none ? Colors.black : Colors.white,
                                        // ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              data.city,
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              data.desc,
                              style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontSize: 16),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              "${data.temp}°C",
                              style: TextStyle(
                                fontSize: 42,
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Text("${snapshot.connectionState} occured"),
            );
          }
          return Center(
            child: Text("Server timed out!"),
          );
        },
        future: _myData!,
      ),
    );
  }
}