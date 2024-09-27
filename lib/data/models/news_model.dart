import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

@JsonSerializable()
class NewsModel {
  final String category;
  final int datetime;
  final String headline;
  final String image;
  final String source;
  final String summary;
  final String url;

  NewsModel({
    required this.category,
    required this.datetime,
    required this.headline,
    required this.image,
    required this.source,
    required this.summary,
    required this.url,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);
}
