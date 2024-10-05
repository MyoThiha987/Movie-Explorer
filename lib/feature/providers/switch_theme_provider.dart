import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_architecture/di/di.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'switch_theme_provider.g.dart';

@riverpod
class SwitchThemeProvider extends _$SwitchThemeProvider {
  late final SharedPreferences _sharedPreferences;

  Future<void> load() async {
    _sharedPreferences = await instance.getAsync<SharedPreferences>();
    int aa = _sharedPreferences.getInt("theme") ?? ThemeMode.light.index;
    state = ThemeMode.values[aa];
  }

  @override
  ThemeMode build() {
    load();
    return ThemeMode.light;
  }

  ThemeMode getThemeMode() {
    return state;
  }

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    await _sharedPreferences.setInt("theme", themeMode.index);
    state = themeMode;
  }
}
