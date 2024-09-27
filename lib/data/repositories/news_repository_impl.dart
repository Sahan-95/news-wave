import '../../domain/entities/news.dart';
import '../../domain/repositories/news_repository.dart';
import '../data_sources/remote_data_source.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsDataSource newsDataSource;

  NewsRepositoryImpl(this.newsDataSource);

  @override
  Future<List<News>> getMarketNews(String category) async {
    try {
      // Fetch the news models from the data source
      final newsModels = await newsDataSource.fetchMarketNews(category);
      return newsModels.map((model) => News.fromModel(model)).toList();

    } catch (e) {
      // Throw an exception in case of any error
      throw Exception('Failed to fetch market news: ${e.toString()}');
    }
  }
}
