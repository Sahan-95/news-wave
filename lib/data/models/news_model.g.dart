// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsModel _$NewsModelFromJson(Map<String, dynamic> json) => NewsModel(
      category: json['category'] as String,
      datetime: (json['datetime'] as num).toInt(),
      headline: json['headline'] as String,
      image: json['image'] as String,
      source: json['source'] as String,
      summary: json['summary'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$NewsModelToJson(NewsModel instance) => <String, dynamic>{
      'category': instance.category,
      'datetime': instance.datetime,
      'headline': instance.headline,
      'image': instance.image,
      'source': instance.source,
      'summary': instance.summary,
      'url': instance.url,
    };
