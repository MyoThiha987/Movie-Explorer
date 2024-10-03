import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_search_textfield_provider.g.dart';

@riverpod
class SearchText extends _$SearchText {
  Timer? _debounceTimer;

  @override
  String build() {
    ref.onDispose(() {
      _debounceTimer?.cancel();
    });
    return '';
  }

  String updateSearchText(String search) {
    if (_debounceTimer != null) {
      _debounceTimer!.cancel();
    }
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      state = search;
    });

    return state;
  }
}
