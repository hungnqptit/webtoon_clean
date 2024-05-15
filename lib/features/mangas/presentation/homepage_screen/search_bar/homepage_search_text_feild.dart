import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webtoon/features/mangas/data/repository/homepage_repository.dart';
import 'package:webtoon/features/mangas/presentation/homepage_screen/search_bar/manga_search_state_provider.dart';

/// Search field used to filter products by name
class MangaSearchTextField extends ConsumerStatefulWidget {
  const MangaSearchTextField({super.key});

  @override
  ConsumerState<MangaSearchTextField> createState() =>
      _ProductsSearchTextFieldState();
}

class _ProductsSearchTextFieldState
    extends ConsumerState<MangaSearchTextField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    // * TextEditingControllers should be always disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: _controller,
      builder: (context, value, _) {
        return TextField(
          controller: _controller,
          autofocus: false,
          style: Theme.of(context).textTheme.titleLarge,
          decoration: InputDecoration(
            hintText: 'Search manga...',
            icon: const Icon(Icons.search),
            suffixIcon: value.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      _controller.clear();
                      ref.read(mangaSearchQueryStateProvider.notifier).state =
                          '';
                    },
                    icon: const Icon(Icons.clear),
                  )
                : null,
          ),
          onChanged: (text) =>
              ref.read(mangaSearchQueryStateProvider.notifier).state = text,
        );
      },
    );
  }
}
