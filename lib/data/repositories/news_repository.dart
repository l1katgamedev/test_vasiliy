
import 'package:test_vasiliy/core/exceptions.dart';
import 'package:test_vasiliy/data/datasources/news_local_datasources.dart';
import 'package:test_vasiliy/data/datasources/news_remote_datasource.dart';
import 'package:test_vasiliy/data/models/news_model.dart';

class NewsRepository {
  Future<List<NewsModel>> getAll() async {
    NewsRemoteDatasource datasource = NewsRemoteDatasource();
    try{
      return await datasource.getAll();
    } catch (e) {
      throw ServerException();
    }
  }

  Future<List<NewsModel>> getAllLocal() async {
    NewsLocalDatasource datasource = NewsLocalDatasource();
    try{
      return await datasource.getAll();
    } catch (e) {
      throw ServerException();
    }
  }

  void saveLocal(NewsModel record)  {
    NewsLocalDatasource datasource = NewsLocalDatasource();
    try{
      return datasource.saveLocal(record);
    } catch (e) {
      throw SaveLocalException();
    }
  }

  void removeLocal(NewsModel record)  {
    NewsLocalDatasource datasource = NewsLocalDatasource();
    try{
      return datasource.removeLocal(record);
    } catch (e) {
      throw SaveLocalException();
    }
  }
}