import 'package:popcornhub/common/constants/translation_constants.dart';
import 'package:popcornhub/presentation/journey/home/movie_tab/tab.dart';

class MovieTabConstants {
  static  List<Tabs> movieTabs = [
    Tabs(index: 0, title: TranslationConstants.popular),
    Tabs(index: 1, title: TranslationConstants.now),
    Tabs(index: 2, title: TranslationConstants.soon),
  ];
}