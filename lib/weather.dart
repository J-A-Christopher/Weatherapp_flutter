import 'dart:async';
import 'dart:convert';

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/city.dart';

import 'models/album.dart';

Future<Album> fetchAlbum({required String city}) async {
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=c82fbc1927df5fc43c67dcd6beb95e7f&units=metric'));
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
  late String cityValue;
  late String countryValue;
  late String stateValue;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum(city: 'mombasa');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App...',
      home: Scaffold(
        // backgroundColor: const Color(0xFF07060d),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              SelectState(
                onCityChanged: (city) => setState(() {
                  cityValue = city;
                  futureAlbum = fetchAlbum(city: city);
                  //print(cityValue);
                }),
                onCountryChanged: (value) {
                  setState(() {
                    countryValue = value;
                  });
                },
                onStateChanged: (value) {
                  setState(() {
                    stateValue = value;

                  });
                },
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 0, 20),
                child: const Text(
                  'Today\'s Report...',
                  style: TextStyle(
                      fontSize: 30, color: Color.fromARGB(255, 82, 79, 79)),
                ),
              ),
              FutureBuilder<Album>(
                  future: futureAlbum,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
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
                            child: Text(
                              snapshot.data!.weather!.first.description ?? '',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 30),
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
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
