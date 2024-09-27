import '../entities/news.dart';
import '../repositories/news_repository.dart';

class GetMarketNews {
  final NewsRepository newsRepository;

  GetMarketNews(this.newsRepository);

  Future<List<News>> execute(String category) async {
    try {
      // Fetch news from the repository
      return await newsRepository.getMarketNews(category);
    } catch (e) {
      // Handle exceptions by rethrowing them
      throw Exception('Failed to fetch market news in use cases: ${e.toString()}');
    }
  }
}
