import 'package:dio/dio.dart';

import 'package:retrofit/retrofit.dart';
import 'package:webtoon/constants/configs.dart';
import 'package:webtoon/features/mangas/domain/get_homepage_spotlight_response.dart';
import 'package:webtoon/features/mangas/domain/get_top_manga_response.dart';

part 'homepage_remote_datasource.g.dart';

@RestApi()
abstract class HomepageRemoteDatasource {
  factory HomepageRemoteDatasource(Dio dio, {String baseUrl}) =
      _HomepageRemoteDatasource;

  @GET('/home_a')
  Future<GetHomepageSpotlightResponse> getSpotlightManga();

  @GET('mangas/top')
  Future<GetTopMangaResponse> getTopMangas({
    @Query('per_page') int perPage = 10,
    @Query('page') int page = 1,
    @Query("duration") DurationTime? duration,
  });
}
