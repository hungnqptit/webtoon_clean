import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:webtoon/features/mangas/data/repository/homepage_repository.dart';
import 'package:webtoon/features/mangas/domain/manga.dart';

part 'manga_service.g.dart';

class MangaService {
  MangaService(this.ref);

  final Ref ref;

  Future<Manga> fetchHomepageManga() async {
    final response =
        await ref.read(mangaRepositoryProvider).getHomepageSpotlight();
    return Manga(
      spotlightMangas: response.data?.spotlightMangas ?? [],
      newChapterMangas: response.data?.newChapterMangas ?? [],
    );
  }
}

@riverpod
MangaService mangaService(MangaServiceRef ref) {
  return MangaService(ref);
}
