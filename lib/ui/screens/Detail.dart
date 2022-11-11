import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rss_feed_2/core/data/model/MediumArticle.dart';
import 'package:flutter_rss_feed_2/ui/screens/Home.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  final MediumArticle mediumArticle;

  const DetailScreen({Key? key, required this.mediumArticle}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home())),
        ),
        title: Text(widget.mediumArticle.title),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Html(
                data: widget.mediumArticle.content,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () => launchUrl(Uri.parse(widget.mediumArticle.link)),
                  icon: const Icon(Icons.link),
                  label: const Text('Visit link'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
