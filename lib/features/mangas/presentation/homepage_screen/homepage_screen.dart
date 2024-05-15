import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webtoon/common/responsive_center.dart';
import 'package:webtoon/constants/app_sizes.dart';
import 'package:webtoon/features/mangas/domain/manga.dart';
import 'package:webtoon/features/mangas/presentation/homepage_screen/spotlight_manga_controller.dart';

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
    AsyncValue<Manga> state = ref.watch(spotlightMangaControllerProvider);

    return Scaffold(
      // appBar: const HomeAppBar(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          ResponsiveSliverCenter(
            padding: const EdgeInsets.all(Sizes.p16),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: Sizes.p32,
                      height: Sizes.p32,
                      child: Image.asset(
                        "assets/icon/icon.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.search,
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('New Here?',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.w900,
                                  )),
                          Text("Start Reading Now!",
                              style: Theme.of(context).textTheme.bodyMedium!),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                    )
                  ],
                ),
              ],
            ),
          ),
          ResponsiveSliverCenter(
            padding: const EdgeInsets.all(Sizes.p16),
            child: state.isLoading
                ? const CircularProgressIndicator()
                : SizedBox(
                    height: Sizes.p12,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.value?.spotlightMangas.length ?? 0,
                      itemBuilder: (context, index) {
                        final item = state.value?.spotlightMangas[index];

                        return Text(item?.name ?? '');
                      },
                    ),
                  ),
            // disable the button if the state is loading
          ),
        ],
      ),
    );
  }
}
