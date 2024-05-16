import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_homepage_spotlight_response.freezed.dart';
part 'get_homepage_spotlight_response.g.dart';

@Freezed(fromJson: false, toJson: false)
class GetHomepageSpotlightResponse with _$GetHomepageSpotlightResponse {
  const factory GetHomepageSpotlightResponse({
    required SpotlightData? data,
  }) = _GetHomepageSpotlightResponse;

  factory GetHomepageSpotlightResponse.fromJson(Map<String, dynamic> json) =>
      _$GetHomepageSpotlightResponseFromJson(json);
}

@Freezed(fromJson: false, toJson: false)
class SpotlightData with _$SpotlightData {
  const factory SpotlightData({
    required List<SpotlightMangas>? spotlightMangas,
    required List<NewChapterMangas>? newChapterMangas,
  }) = _SpotlightData;

  factory SpotlightData.fromJson(Map<String, dynamic> json) =>
      _$SpotlightDataFromJson(json);
}

@Freezed(fromJson: false, toJson: false)
class NewChapterMangas with _$NewChapterMangas {
  const factory NewChapterMangas({
    required int? id,
    required String? name,
    required String? coverUrl,
    required String? coverMobileUrl,
    required String? newestChapterNumber,
    required int? newestChapterId,
    required DateTime? newestChapterCreatedAt,
  }) = _NewChapterMangas;

  factory NewChapterMangas.fromJson(Map<String, dynamic> json) =>
      _$NewChapterMangasFromJson(json);
}

@Freezed(fromJson: false, toJson: false)
class SpotlightMangas with _$SpotlightMangas {
  const factory SpotlightMangas({
    required int? id,
    required String? name,
    required String? panoramaUrl,
    required String? panoramaMobileUrl,
    required String? panoramaDominantColor,
    required String? panoramaDominantColor2,
    required String? description,
  }) = _SpotlightMangas;

  factory SpotlightMangas.fromJson(Map<String, dynamic> json) =>
      _$SpotlightMangasFromJson(json);
}
