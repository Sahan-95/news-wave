import '../../data/models/news_model.dart';

class News {
  final String category;
  final int datetime;
  final String headline;
  final String image;
  final String source;
  final String summary;
  final String url;

  News({
    required this.category,
    required this.datetime,
    required this.headline,
    required this.image,
    required this.source,
    required this.summary,
    required this.url,
  });

  factory News.fromModel(NewsModel model) {
    return News(
        category: model.category,
        datetime: model.datetime,
        headline: model.headline,
        image: model.image,
        source: model.source,
        summary: model.summary,
        url: model.url);
  }
}
