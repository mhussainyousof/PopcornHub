import 'package:flutter/material.dart';
import 'package:popcornhub/common/screenutil/screenutil.dart';
import 'package:popcornhub/presentation/journey/home/home_screen.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';
import 'package:popcornhub/presentation/theme/theme_text.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: AppColor.vulcan,
          surface: AppColor.vulcan,
        ),
        textTheme: ThemeText.getTextTheme(),
        appBarTheme: AppBarTheme(elevation: 0),
      ),
      home: HomeScreen(),
    );
  }
}
