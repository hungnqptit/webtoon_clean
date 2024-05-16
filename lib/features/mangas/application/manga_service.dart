import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:webtoon/constants/configs.dart';
import 'package:webtoon/features/mangas/data/repository/homepage_repository.dart';
import 'package:webtoon/features/mangas/domain/get_homepage_spotlight_response.dart';
import 'package:webtoon/features/mangas/domain/get_top_manga_response.dart';
import 'package:webtoon/features/mangas/domain/manga.dart';

part 'manga_service.g.dart';

class MangaService {
  MangaService(this.ref);

  final Ref ref;
  final Manga _manga = const Manga();

  Future<Manga> fetchHomepageManga() async {
    final response =
        await ref.read(mangaRepositoryProvider).getHomepageSpotlight();
    _manga.setListSpotlightMangas(
      response.data?.spotlightMangas ?? [],
    );
    _manga.setListNewChapterMangas(
      response.data?.newChapterMangas ?? [],
    );
    return _manga;
  }

  Future<Manga> fetchTopManga({
    int perPage = 10,
    int page = 1,
    DurationTime? duration,
  }) async {
    final response = await ref.read(mangaRepositoryProvider).getTopManga(
          perPage: perPage,
          page: page,
          duration: duration,
        );

    return _manga.setListTopMangaData(response.data ?? []);
  }

  List<SpotlightMangas> get getListSpotlight {
    return _manga.spotlightMangas;
  }

  List<NewChapterMangas> get getListNewChapterMangas {
    return _manga.newChapterMangas;
  }

  List<GetTopMangaData?> get getListTopMangaData {
    return _manga.topMangaData;
  }
}

@riverpod
MangaService mangaService(MangaServiceRef ref) {
  return MangaService(ref);
}
