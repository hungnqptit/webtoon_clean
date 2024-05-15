// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_homepage_spotlight_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetHomepageSpotlightResponse _$GetHomepageSpotlightResponseFromJson(
        Map<String, dynamic> json) =>
    GetHomepageSpotlightResponse(
      data: json['data'] == null
          ? null
          : SpotlightData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetHomepageSpotlightResponseToJson(
        GetHomepageSpotlightResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

SpotlightData _$SpotlightDataFromJson(Map<String, dynamic> json) =>
    SpotlightData(
      spotlightMangas: (json['spotlight_mangas'] as List<dynamic>?)
          ?.map((e) => SpotlightMangas.fromJson(e as Map<String, dynamic>))
          .toList(),
      newChapterMangas: (json['new_chapter_mangas'] as List<dynamic>?)
          ?.map((e) => NewChapterMangas.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SpotlightDataToJson(SpotlightData instance) =>
    <String, dynamic>{
      'spotlight_mangas': instance.spotlightMangas,
      'new_chapter_mangas': instance.newChapterMangas,
    };

NewChapterMangas _$NewChapterMangasFromJson(Map<String, dynamic> json) =>
    NewChapterMangas(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      coverUrl: json['cover_url'] as String?,
      coverMobileUrl: json['cover_mobile_url'] as String?,
      newestChapterNumber: json['newest_chapter_number'] as String?,
      newestChapterId: (json['newest_chapter_id'] as num?)?.toInt(),
      newestChapterCreatedAt: json['newest_chapter_created_at'] == null
          ? null
          : DateTime.parse(json['newest_chapter_created_at'] as String),
    );

Map<String, dynamic> _$NewChapterMangasToJson(NewChapterMangas instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cover_url': instance.coverUrl,
      'cover_mobile_url': instance.coverMobileUrl,
      'newest_chapter_number': instance.newestChapterNumber,
      'newest_chapter_id': instance.newestChapterId,
      'newest_chapter_created_at':
          instance.newestChapterCreatedAt?.toIso8601String(),
    };

SpotlightMangas _$SpotlightMangasFromJson(Map<String, dynamic> json) =>
    SpotlightMangas(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      panoramaUrl: json['panorama_url'] as String?,
      panoramaMobileUrl: json['panorama_mobile_url'] as String?,
      panoramaDominantColor: json['panorama_dominant_color'] as String?,
      panoramaDominantColor2: json['panorama_dominant_color2'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$SpotlightMangasToJson(SpotlightMangas instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'panorama_url': instance.panoramaUrl,
      'panorama_mobile_url': instance.panoramaMobileUrl,
      'panorama_dominant_color': instance.panoramaDominantColor,
      'panorama_dominant_color2': instance.panoramaDominantColor2,
      'description': instance.description,
    };
