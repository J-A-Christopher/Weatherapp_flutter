import 'package:flutter/foundation.dart';
import '../models/newsModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NewsProvider extends ChangeNotifier {
  Autogenerated _newsData = Autogenerated();

  Autogenerated get newsData => _newsData;

  Future<Autogenerated> getNewsData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=${dotenv.env['API_KEY']}'));
      if (response.statusCode == 200) {
        _newsData = Autogenerated.fromJson(jsonDecode(response.body));
        notifyListeners();
      } else {
        throw Exception('Failed to load Album');
      }
    } catch (error) {
      rethrow;
    }
    return _newsData;
  }
}
