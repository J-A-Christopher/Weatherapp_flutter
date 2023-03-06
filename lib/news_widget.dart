import 'package:flutter/material.dart';
import 'package:weather_app/models/newsModel.dart';
import './newsdetailsScreen.dart';

class NewsWidget extends StatefulWidget {
  final List<Articles> news;
  const NewsWidget({super.key, required this.news});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.news.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: double.infinity,
            height: 135,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewsDetailsScreen(
                              news: widget.news[index],
                            )));
              },
              child: Card(
                // color: Colors.green,

                elevation: 5,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)),
                          child: Image.network(
                            widget.news[index].urlToImage ??
                                'https://reactnativecode.com/wp-content/uploads/2018/02/Default_Image_Thumbnail.png,',
                            fit: BoxFit.cover,
                          )),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            Text(
                              widget.news[index].title ?? '',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                            ),
                            Text(
                              widget.news[index].description ??
                                  widget.news[index].content ??
                                  '',
                              maxLines: 4,
                            ),
                            widget.news[index].author != null
                                ? Text(
                                    'On ${widget.news[index].publishedAt}  ${widget.news[index].author!.startsWith('http')}by${widget.news[index].author}',
                                    maxLines: 1)
                                : const SizedBox.shrink()
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
