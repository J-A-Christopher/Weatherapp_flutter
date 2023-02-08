import 'package:flutter/material.dart';
import 'package:weather_app/models/newsModel.dart';

class NewsDetailsScreen extends StatelessWidget {
  final Articles news;

  const NewsDetailsScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {}, child: const Icon(Icons.share)),
      appBar: AppBar(
        title: Text(news.title ?? ''),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              news.urlToImage ??
                  'https://reactnativecode.com/wp-content/uploads/2018/02/Default_Image_Thumbnail.png',
              height: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                news.description ?? news.content ?? '',
                style: const TextStyle(fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(news.content ?? '',
                  style: const TextStyle(fontSize: 25)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Author : ${news.author ?? 'News Media'}',
                  style: const TextStyle(fontSize: 25)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Published On  : ${news.publishedAt}',
                  style: const TextStyle(fontSize: 25)),
            ),
          ],
        ),
      ),
    );
  }
}
