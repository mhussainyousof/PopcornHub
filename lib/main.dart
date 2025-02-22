import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:popcornhub/data/di/get_it.dart';
import 'package:popcornhub/presentation/movie_app.dart';



void main()async{
WidgetsFlutterBinding.ensureInitialized();
unawaited(
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  await init();
  runApp(MovieApp());
}

