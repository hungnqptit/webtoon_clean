import 'package:webtoon/features/mangas/domain/get_homepage_spotlight_response.dart';
import 'package:webtoon/features/mangas/domain/get_top_manga_response.dart';

class Manga {
  const Manga({
    this.spotlightMangas = const [],
    this.newChapterMangas = const [],
    this.topMangaData = const [],
  });

  final List<SpotlightMangas> spotlightMangas;
  final List<NewChapterMangas> newChapterMangas;
  final List<GetTopMangaData?> topMangaData;
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

  Manga addTopMangaData(GetTopMangaData topMangaData) {
    return copyWith(topMangaData: [...this.topMangaData, topMangaData]);
  }

  Manga setListSpotlightMangas(List<SpotlightMangas> spotlightMangas) {
    return copyWith(spotlightMangas: spotlightMangas);
  }

  Manga setListNewChapterMangas(List<NewChapterMangas> newChapterMangas) {
    return copyWith(newChapterMangas: newChapterMangas);
  }

  Manga setListTopMangaData(List<GetTopMangaData?> topMangaData) {
    return copyWith(topMangaData: topMangaData);
  }

  Manga copyWith({
    List<SpotlightMangas>? spotlightMangas,
    List<NewChapterMangas>? newChapterMangas,
    List<GetTopMangaData?>? topMangaData,
  }) {
    return Manga(
      spotlightMangas: spotlightMangas ?? this.spotlightMangas,
      newChapterMangas: newChapterMangas ?? this.newChapterMangas,
      topMangaData: topMangaData ?? this.topMangaData,
    );
  }
}
