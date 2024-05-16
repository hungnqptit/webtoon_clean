import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webtoon/features/mangas/presentation/homepage_screen/home_header_sliver.dart';
import 'package:webtoon/features/mangas/presentation/homepage_screen/spotlight_recent_sliver/spotlight/spotlight_slivers.dart';
import 'package:webtoon/features/mangas/presentation/homepage_screen/spotlight_recent_sliver/spotlight_recent_manga_controller.dart';

class HomepageScreen extends ConsumerStatefulWidget {
  const HomepageScreen({super.key});

  @override
  ConsumerState<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends ConsumerState<HomepageScreen> {
  // * Use a [ScrollController] to register a listener that dismisses the
  // * on-screen keyboard when the user scrolls.
  // * This is needed because this page has a search field that the user can
  // * type into.
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_dismissOnScreenKeyboard);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_dismissOnScreenKeyboard);
    super.dispose();
  }

  // When the search text field gets the focus, the keyboard appears on mobile.
  // This method is used to dismiss the keyboard when the user scrolls.
  void _dismissOnScreenKeyboard() {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const HomeAppBar(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () =>
              ref.refresh(spotlightRecentMangaControllerProvider.future),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            slivers: const [
              HomeHeaderSliver(),
              HomeSpotlightSliver(),
            ],
          ),
        ),
      ),
    );
  }
}
