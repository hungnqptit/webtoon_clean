import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'manga_search_state_provider.g.dart';

final mangaSearchQueryStateProvider = StateProvider<String>((ref) {
  return '';
});

@riverpod
Future<List<dynamic>> mangaSearchResults(MangaSearchResultsRef ref) async {
  // final searchQuery = ref.watch(productsSearchQueryStateProvider);
  return [];
}
