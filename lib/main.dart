import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:popcornhub/data/di/get_it.dart';
import 'package:popcornhub/presentation/movie_app.dart';




class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
void main()async{
WidgetsFlutterBinding.ensureInitialized();
unawaited(
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  await init();


  runApp(MovieApp());
}

