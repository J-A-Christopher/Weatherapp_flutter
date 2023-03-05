import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/newsModel.dart';
import 'news_widget.dart';
import 'package:provider/provider.dart';
import './provider/news_provider.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  // Future<Autogenerated> getNewsData() async {
  //   final response = await http.get(Uri.parse(
  //       'https://newsapi.org/v2/everything?q=apple&from=2023-02-28&to=2023-02-28&sortBy=popularity&apiKey=8b38b42439bd40d3a599005d0cc8146d'));
  //   if (response.statusCode == 200) {
  //     return Autogenerated.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to load Album');
  //   }
  // }
  // https://newsdata.io/api/1/news?apikey=pub_162711355faa3f8fc27cd7fab7f4ef0e6f57a&country=ke

  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(Duration.zero,(){
  //     Provider.of<NewsProvider>(context, listen: false).getNewsData();
  //   });
  //   // getNewsData();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('News')),
        ),
        body: FutureBuilder<Autogenerated>(
          future: Provider.of<NewsProvider>(context).getNewsData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Articles> news = snapshot.data?.articles as List<Articles>;

              return NewsWidget(news: news);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          },
        ));
  }
}
