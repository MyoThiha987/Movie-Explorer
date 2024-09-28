import 'package:flutter/material.dart';
import 'package:flutter_architecture/di/di.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'feature/main_page.dart';

void main() async {
  await initAppModule();
  runApp(const ProviderScope(child: MainPage()));
}
