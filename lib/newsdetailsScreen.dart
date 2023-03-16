import 'package:flutter/material.dart';
import 'package:weather_app/models/newsModel.dart';
import 'package:share_plus/share_plus.dart';
import 'package:palette_generator/palette_generator.dart';

class NewsDetailsScreen extends StatefulWidget {
  final Articles news;

  const NewsDetailsScreen({super.key, required this.news});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

var trip;

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  Future<PaletteGenerator> _updatePaletteGenerator() async {
    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
            Image.network(widget.news.urlToImage!).image);
    return paletteGenerator;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Share.share('Read more..${widget.news.url}');
        },
        child: const Icon(Icons.share),
        backgroundColor: trip,
      ),
      appBar: AppBar(
        title: Text(widget.news.title ?? ''),
        backgroundColor: trip,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: _updatePaletteGenerator(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    trip = snapshot.data!.dominantColor!.color;
                    return Text('color: ${trip.toString()}');
                  }
                  return Text('error');
                }),
            Image.network(
              widget.news.urlToImage ??
                  'https://reactnativecode.com/wp-content/uploads/2018/02/Default_Image_Thumbnail.png',
              height: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.news.description ?? widget.news.content ?? '',
                style: const TextStyle(fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.news.content ?? '',
                  style: const TextStyle(fontSize: 25)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Author : ${widget.news.author ?? 'News Media'}',
                  style: const TextStyle(fontSize: 25)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Published On  : ${widget.news.publishedAt}',
                  style: const TextStyle(fontSize: 25)),
            ),
          ],
        ),
      ),
    );
  }
}
