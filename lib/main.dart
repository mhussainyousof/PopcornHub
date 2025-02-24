import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:popcornhub/data/di/get_it.dart';
import 'package:popcornhub/data/table/movie_table.dart';
import 'package:popcornhub/presentation/movie_app.dart';


void main()async{
WidgetsFlutterBinding.ensureInitialized();
unawaited(
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));

  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(MovieTableAdapter());
  await init();
  runApp(MovieApp());
}
