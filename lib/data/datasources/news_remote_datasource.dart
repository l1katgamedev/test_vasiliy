import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:test_vasiliy/core/dio_singleton.dart';
import 'package:test_vasiliy/core/env.dart';
import 'package:test_vasiliy/core/exceptions.dart';
import 'package:test_vasiliy/data/models/news_model.dart';
import 'package:xml2json/xml2json.dart';

class NewsRemoteDatasource {

  Future<List<NewsModel>> getAll() async {

    try {
      final res = await DioSingleton().instance().get("$URL/rss_news.xml");

      Xml2Json xml2json = Xml2Json();
      xml2json.parse(res.toString());
      Map jsonData = jsonDecode(xml2json.toGData());

      List<dynamic> recordsJson = jsonData['rss']['channel']['item'];
      return recordsJson.map((json) => NewsModel.fromJson(json)).toList();
    } on DioError catch (e) {

      if(e.response != null) {
        throw ServerException();
      }

      throw NetworkException();
    }

  }
}