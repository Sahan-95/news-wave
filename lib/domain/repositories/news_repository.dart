import '../entities/news.dart';

abstract class NewsRepository {
  Future<List<News>> getMarketNews(String category);
}
