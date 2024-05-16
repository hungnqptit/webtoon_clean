import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:webtoon/common/base_network_image.dart';
import 'package:webtoon/common/responsive_center.dart';
import 'package:webtoon/constants/app_sizes.dart';
import 'package:webtoon/features/mangas/domain/get_homepage_spotlight_response.dart';
import 'package:webtoon/features/mangas/presentation/homepage_screen/spotlight_recent_sliver/spotlight/spotlight_shimmer.dart';
import 'package:webtoon/features/mangas/presentation/homepage_screen/spotlight_recent_sliver/spotlight_recent_manga_controller.dart';

import 'package:webtoon/utils/list_extension.dart';
import 'package:webtoon/utils/ref_extension.dart';

class HomeSpotlightSliver extends ConsumerStatefulWidget {
  const HomeSpotlightSliver({super.key});
  static const mangaSpotlightWidthPercent = 0.65;
  static const mangaSpotlightRatio = 18 / 15;

  @override
  ConsumerState<HomeSpotlightSliver> createState() =>
      _HomeSpotlightSliverState();
}

class _HomeSpotlightSliverState extends ConsumerState<HomeSpotlightSliver> {
  int _currentIndex = 0;

  late final carouselOptions = CarouselOptions(
    autoPlayCurve: Curves.fastOutSlowIn,
    aspectRatio: HomeSpotlightSliver.mangaSpotlightRatio,
    viewportFraction: HomeSpotlightSliver.mangaSpotlightWidthPercent,
    enlargeCenterPage: true,
    enableInfiniteScroll: true,
    enlargeStrategy: CenterPageEnlargeStrategy.scale,
    padEnds: false,
    disableCenter: true,
    onPageChanged: _onPageChanged,
  );

  _onPageChanged(index, _) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(spotlightRecentMangaControllerProvider);
    ref.listen<AsyncValue>(
      spotlightRecentMangaControllerProvider,
      (_, state) => state.showSnackbarOnError(context),
    );

    return ResponsiveSliverCenter(
        child: switch (state) {
      AsyncData(:final value) => CarouselSlider(
          items: value.spotlightMangas
              .mapIndexed(
                (index, item) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: Sizes.p16),
                  child: Stack(
                    children: [
                      _renderBackground(item),
                      _renderTitleDescription(index, item)
                    ],
                  ),
                ),
              )
              .toList(),
          options: carouselOptions,
        ),
      AsyncError() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
          child: Text(
            "Error occurred!",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      _ => const SpotlightShimmer(),
    });
  }

  Positioned _renderBackground(SpotlightMangas item) {
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(Sizes.p8)),
        child: BaseNetworkImage(
          imageUrl: item.panoramaUrl ?? "",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Positioned _renderTitleDescription(int index, SpotlightMangas item) {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: AnimatedOpacity(
          opacity: _currentIndex == index ? 1 : 0,
          duration: const Duration(milliseconds: 300),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(Sizes.p8)),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.4),
                  Colors.transparent,
                ],
                stops: const [0.4, 0.8, 1],
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  item.description ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.white,
                      ),
                ),
                const Gap(Sizes.p8)
              ],
            ),
          ),
        ));
  }
}
