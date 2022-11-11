import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rss_feed_2/core/data/model/MediumArticle.dart';
import 'package:flutter_rss_feed_2/styles/Constants.dart';
import 'package:flutter_rss_feed_2/ui/screens/Detail.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<MediumArticle> _mediumArticles = [];
  bool isLoading = false;

  Future<RssFeed?> getMediumRssFeed() async {
    try {
      final client = http.Client();
      final response = await client.get((Uri.parse(MEDIUM_RSS_FEED)));
      return RssFeed.parse(response.body);
    } catch (e) {
      if (kDebugMode) {
        print("**# $e");
      }
    }
    return null;
  }



  @override
  void initState() {
    super.initState();

    isLoading = true;

    _mediumArticles.clear();

    getMediumRssFeed().then((feed) {

      /// Get the title of each item
      if (feed?.items != null) {
        for (RssItem rssItem in feed!.items!) {
          // Create a new Medium article from the rssitem
          MediumArticle mediumArticle = MediumArticle(
              title: rssItem.title!,
              link: rssItem.link!,
              publishedDate: rssItem.pubDate.toString(),
              imgSrc: rssItem.content!.images.first,
              content: rssItem.content!.value);
          _mediumArticles.add(mediumArticle);
        } //for
      } //if
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Medium Rss Feed'),
        centerTitle: true,
      ),
      body: Stack(children: [
        isLoading == false
            ? ListView.builder(
                itemCount: _mediumArticles.length,
                padding: const EdgeInsets.all(8.0),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Image(
                      image: CachedNetworkImageProvider(
                        _mediumArticles[index].imgSrc,
                        errorListener: () => const Icon(Icons.error),
                      ),
                      errorBuilder: (_, __, ___) => const Icon(Icons.error),
                      height: 50.0,
                      width: 50.0 ,
                    ),
                    title: Text(_mediumArticles[index].title),
                    subtitle: Text(_mediumArticles[index].publishedDate),
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(
                          mediumArticle: _mediumArticles[index],
                        ),
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_right),
                  );
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ]),
    );
  }
}
