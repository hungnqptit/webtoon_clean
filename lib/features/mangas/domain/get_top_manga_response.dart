import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_top_manga_response.freezed.dart';
part 'get_top_manga_response.g.dart';

@freezed
class GetTopMangaResponse with _$GetTopMangaResponse {
  const factory GetTopMangaResponse({
    required List<GetTopMangaData?>? data,
    required Metadata? metadata,
  }) = _GetTopMangaResponse;

  factory GetTopMangaResponse.fromJson(Map<String, dynamic> json) =>
      _$GetTopMangaResponseFromJson(json);
}

@freezed
class GetTopMangaData with _$GetTopMangaData {
  const factory GetTopMangaData({
    required int? id,
    required String? name,
    required String? coverUrl,
    required String? coverMobileUrl,
    required String? newestChapterNumber,
    required int? newestChapterId,
    required String? newestChapterCreatedAt,
    required int? viewsCount,
    required int? viewsCountWeek,
    required int? viewsCountMonth,
  }) = _GetTopMangaData;

  factory GetTopMangaData.fromJson(Map<String, dynamic> json) =>
      _$GetTopMangaDataFromJson(json);
}

@freezed
class Metadata with _$Metadata {
  const factory Metadata({
    required int? totalCount,
    required int? totalPages,
    required int? currentPage,
    required int? perPage,
  }) = _Metadata;

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);
}
