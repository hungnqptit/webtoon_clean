import 'package:dio/dio.dart';

import 'package:retrofit/retrofit.dart';
import 'package:webtoon/features/mangas/domain/get_homepage_spotlight_response.dart';

part 'homepage_remote_datasource.g.dart';

@RestApi()
abstract class HomepageRemoteDatasource {
  factory HomepageRemoteDatasource(Dio dio, {String baseUrl}) =
      _HomepageRemoteDatasource;

  @GET('/home_a')
  Future<GetHomepageSpotlightResponse> getSpotlightManga();
}
