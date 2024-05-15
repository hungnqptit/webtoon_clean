import 'package:webtoon/features/mangas/domain/get_homepage_spotlight_response.dart';

class Manga {
  const Manga({
    this.spotlightMangas = const [],
    this.newChapterMangas = const [],
  });

  final List<SpotlightMangas> spotlightMangas;
  final List<NewChapterMangas> newChapterMangas;

  set spotlightMangas(List<SpotlightMangas> value) {
    spotlightMangas = value;
  }

  set newChapterMangas(List<NewChapterMangas> value) {
    newChapterMangas = value;
  }
}

extension MutableManga on Manga {
  Manga addSpotlightMangas(SpotlightMangas spotlightMangas) {
    return copyWith(
        spotlightMangas: [...this.spotlightMangas, spotlightMangas]);
  }

  Manga addNewChapterMangas(NewChapterMangas newChapterMangas) {
    return copyWith(
        newChapterMangas: [...this.newChapterMangas, newChapterMangas]);
  }

  Manga copyWith({
    List<SpotlightMangas>? spotlightMangas,
    List<NewChapterMangas>? newChapterMangas,
  }) {
    return Manga(
      spotlightMangas: spotlightMangas ?? this.spotlightMangas,
      newChapterMangas: newChapterMangas ?? this.newChapterMangas,
    );
  }
}
