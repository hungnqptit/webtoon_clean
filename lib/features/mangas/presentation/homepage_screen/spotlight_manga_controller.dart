import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:webtoon/features/mangas/application/manga_service.dart';
import 'package:webtoon/features/mangas/domain/manga.dart';

part 'spotlight_manga_controller.g.dart';

@Riverpod()
class SpotlightMangaController extends _$SpotlightMangaController {
  @override
  Future<Manga> build() async {
    final manga = ref.watch(mangaServiceProvider).fetchHomepageManga();

    return manga;
  }
}
