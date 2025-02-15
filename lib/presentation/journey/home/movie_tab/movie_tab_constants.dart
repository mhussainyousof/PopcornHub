import 'package:flutter/material.dart';
import 'package:popcornhub/presentation/journey/home/movie_tab/tab.dart';

class MovieTabConstants {
  static  List<Tabs> movieTabs = [
    Tabs(index: 0, title: 'Popular'),
    Tabs(index: 1, title: 'Now'),
    Tabs(index: 2, title: 'Soon'),
  ];
}