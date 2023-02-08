import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_icons/weather_icons.dart';
import './models/album.dart';
// import 'package:shared_preferences/shared_preferences.dart';

Future<Album> fetchAlbum({required String place}) async {
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$place&appid=c82fbc1927df5fc43c67dcd6beb95e7f&units=metric'));

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Album');
  }
}

class MyWeather extends StatefulWidget {
  const MyWeather({super.key});

  @override
  State<MyWeather> createState() => _MyWeatherState();
}

class _MyWeatherState extends State<MyWeather> {
  late Future<Album> futureAlbum;

  late TextEditingController region;
  String place = '';

  Future<String?> openDialog() => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            content: TextField(
              controller: region,
              autofocus: true,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Add a City',
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => {
                        setState(() {
                          futureAlbum = fetchAlbum(place: region.text);
                        }),
                        Navigator.of(context).pop(region.text),
                        region.clear(),
                        const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            })
                      },
                  child: const Text('Add'))
            ],
          ));

  @override
  void initState() {
    super.initState();
    region = TextEditingController();
    futureAlbum = fetchAlbum(place: 'Mombasa');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App...',
      home: Scaffold(
        backgroundColor: const Color(0xFF07060d),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 0, 20),
                child: const Text(
                  'Today\'s Report...',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 120),
                    child: IconButton(
                        onPressed: () async {
                          final place = await openDialog();
                          if (place == null || place.isEmpty) return;
                          setState(() {
                            this.place = place;
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 40,
                        )),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      place,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
              FutureBuilder<Album>(
                  future: futureAlbum,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      String getClockInUtcPlus3Hours(int timeSinceEpochInSec) {
                        final time = DateTime.fromMillisecondsSinceEpoch(
                                timeSinceEpochInSec * 1000,
                                isUtc: true)
                            .add(const Duration(hours: 3));
                        return '${time.hour}:${time.second}';
                      }

                      var sunriseData = snapshot.data!.sys?.sunrise;
                      var sunsetData = snapshot.data!.sys?.sunset;
                      var sunriseConversion =
                          getClockInUtcPlus3Hours(sunriseData!);
                      var sunsetConversion =
                          getClockInUtcPlus3Hours(sunsetData!);

                      return Column(
                        children: [
                          SizedBox(
                              height: 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  Text(
                                    'Country:${snapshot.data!.sys!.country}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )
                                ],
                              )),
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50)),
                            child: SizedBox(
                              child: Card(
                                color: const Color(0xFF07060d),
                                elevation: 5,
                                child: Image.network(
                                    'http://openweathermap.org/img/wn/${snapshot.data!.weather!.first.icon ?? ''}@4x.png'),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 40),
                            child: Column(
                              children: [
                                Text(
                                  snapshot.data!.weather!.first.description ??
                                      '',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 30),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        const Icon(
                                          WeatherIcons.thermometer,
                                          color: Colors.white,
                                          size: 50,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'Temp:${snapshot.data!.main!.temp}\u2103',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24),
                                        ),
                                      ],
                                      // child:
                                    ),
                                    Column(
                                      children: [
                                        const Icon(
                                          WeatherIcons.humidity,
                                          color: Colors.white,
                                          size: 50,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'Humidity:${snapshot.data!.main!.humidity}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        const Icon(
                                          WeatherIcons.wind_beaufort_1,
                                          color: Colors.white,
                                          size: 50,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'Wind Speed:${snapshot.data!.wind?.speed}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Icon(
                                          WeatherIcons.thermometer_exterior,
                                          color: Colors.white,
                                          size: 50,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          child: Text(
                                            'Flike:${snapshot.data!.main!.feelsLike}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 24),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        const Icon(
                                          WeatherIcons.wind_deg_0,
                                          color: Colors.white,
                                          size: 50,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'Wind Temp:${snapshot.data!.wind?.deg}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Icon(
                                          WeatherIcons.barometer,
                                          color: Colors.white,
                                          size: 50,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          child: Text(
                                            'Atm.P:${snapshot.data!.main!.pressure}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 24),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    color: const Color(0xf87878787),
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      // margin: EdgeInsets.only(left: 20),
                                      height: 150,
                                      width: 280,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                'Sunrise: \n $sunriseConversion',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                              const Icon(
                                                WeatherIcons.sunrise,
                                                color: Colors.yellow,
                                                size: 60,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                'Sunset: \n $sunsetConversion',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                              const Icon(
                                                WeatherIcons.sunset,
                                                color: Colors.brown,
                                                size: 60,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(
                            Icons.signal_wifi_connected_no_internet_4_rounded,
                            color: Colors.white,
                            size: 50,
                          ),
                          Text(
                            'Unable to Process Request..!',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          )
                        ],
                      );
                    }
                    return const CircularProgressIndicator(
                      color: Colors.white,
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
