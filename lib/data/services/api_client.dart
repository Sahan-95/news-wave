import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../models/news_model.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://finnhub.io/api/v1")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/news")
  Future<List<NewsModel>> getMarketNews(
      @Query("category") String category, @Query("token") String apiKey);
}
