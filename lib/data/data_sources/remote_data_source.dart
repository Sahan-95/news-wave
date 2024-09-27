import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/news_model.dart';
import '../services/api_client.dart';

abstract class NewsDataSource {
  Future<List<NewsModel>> fetchMarketNews(String category);
}

class NewsDataSourceImpl implements NewsDataSource {
  final ApiClient apiClient;
  final String apiKey = dotenv.env['API_KEY']!;

  NewsDataSourceImpl(this.apiClient);

  @override
  Future<List<NewsModel>> fetchMarketNews(String category) async {
    final response = await apiClient.getMarketNews(category, apiKey);
    return response;
  }
}
