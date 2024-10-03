import 'package:flutter/material.dart';
import 'package:flutter_architecture/data/datasource/local/enitiy/movie_entity.dart';
import 'package:flutter_architecture/di/di.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'feature/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  await Hive.initFlutter((await getApplicationDocumentsDirectory()).path);
  Hive.registerAdapter(MovieEntityAdapter());
  await Hive.openBox<MovieEntity>("movies");
  runApp(const ProviderScope(child: MainPage()));
}
