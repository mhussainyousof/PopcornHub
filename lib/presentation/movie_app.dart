import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcornhub/common/screenutil/screenutil.dart';
import 'package:popcornhub/presentation/journey/home/home_screen.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';
import 'package:popcornhub/presentation/theme/theme_text.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder:(context, child) {
        return MaterialApp(
        title: 'Movie App',
        theme: ThemeData(
          colorScheme: ColorScheme.light(
            secondaryContainer: AppColor.royalBlue,
            secondary: AppColor.royalBlue,
            primary: AppColor.vulcan,
            surface: AppColor.vulcan,
          ),
          textTheme: ThemeText.getTextTheme(),
          appBarTheme: AppBarTheme(elevation: 0),
        ),
        home: HomeScreen(),
      );
      },
      
    );
  }
}
