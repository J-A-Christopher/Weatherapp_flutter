import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
import '../models/album.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherProvider extends ChangeNotifier {
  Album _weather = Album();
  String _place = 'Mombasa';

  String get place => _place;

  Album get weather => _weather;
  Future<Album> fetchAlbum({String place = 'Mombasa'}) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$place&appid=${dotenv.env['API_WEATHER']}&units=metric'));

      if (response.statusCode == 200) {
        _weather = Album.fromJson(jsonDecode(response.body));
        notifyListeners();
      } else {
        throw Exception('Failed to load Album');
      }
    } catch (error) {
      rethrow;
    }
    return _weather;
  }

  void getPlace(String place) {
    _place = place;
  }
}
