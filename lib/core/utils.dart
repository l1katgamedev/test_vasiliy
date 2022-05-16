import 'dart:convert';

import '../data/models/news_model.dart';
import 'env.dart';

bool isNewsSaved(NewsModel record) {
  List<String>? cached = prefs.getStringList(SAVED_PREFS);
  cached ??= [];
  bool flag = false;

  for (var el in cached) {
    if (record.title.toString() ==
        NewsModel.fromJson(jsonDecode(el)).title.toString()) {
      flag = true;
      break;
    }
  }

  return flag;
}
