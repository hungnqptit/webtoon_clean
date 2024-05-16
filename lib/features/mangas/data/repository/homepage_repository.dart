import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:webtoon/common/dio.dart';
import 'package:webtoon/constants/configs.dart';
import 'package:webtoon/features/mangas/data/datasource/homepage_remote_datasource.dart';
import 'package:webtoon/features/mangas/domain/get_homepage_spotlight_response.dart';
import 'package:webtoon/features/mangas/domain/get_top_manga_response.dart';

part 'homepage_repository.g.dart';

class MangaRepository {
  final Dio dio;

  MangaRepository({required this.dio});

  Future<GetHomepageSpotlightResponse> getHomepageSpotlight() async {
    final response = await HomepageRemoteDatasource(dio).getSpotlightManga();

    return response;
  }

  Future<GetTopMangaResponse> getTopManga({
    int perPage = 10,
    int page = 1,
    DurationTime? duration,
  }) async {
    final response = await HomepageRemoteDatasource(dio).getTopMangas(
      page: perPage,
      perPage: page,
      duration: duration,
    );

    return response;
  }
}

@riverpod
MangaRepository mangaRepository(MangaRepositoryRef ref) {
  return MangaRepository(dio: BaseDio.getInstance().getDio());
}
