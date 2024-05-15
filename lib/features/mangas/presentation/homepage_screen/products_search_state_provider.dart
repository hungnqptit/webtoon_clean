import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_search_state_provider.g.dart';

final productsSearchQueryStateProvider = StateProvider<String>((ref) {
  return '';
});

@riverpod
Future<List<dynamic>> productsSearchResults(
    ProductsSearchResultsRef ref) async {
  // final searchQuery = ref.watch(productsSearchQueryStateProvider);
  return [];
}
