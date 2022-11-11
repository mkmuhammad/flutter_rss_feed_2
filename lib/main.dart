import 'package:flutter/material.dart';
import 'package:flutter_rss_feed_2/styles/Theme.dart';
import 'package:flutter_rss_feed_2/ui/screens/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Medium RSS Feed Demo',
      theme: AppTheme.appThemeDataLight,
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
