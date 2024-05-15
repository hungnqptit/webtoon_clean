import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webtoon/common/base_network_image.dart';
import 'package:webtoon/common/responsive_center.dart';
import 'package:webtoon/constants/app_sizes.dart';
import 'package:webtoon/features/mangas/presentation/homepage_screen/spotlight_recent_sliver/spotlight/spotlight_shimmer.dart';
import 'package:webtoon/features/mangas/presentation/homepage_screen/spotlight_recent_sliver/spotlight_recent_manga_controller.dart';

import 'package:webtoon/utils/list_extension.dart';
import 'package:webtoon/utils/ref_extension.dart';

class HomeSpotlightSliver extends ConsumerWidget {
  const HomeSpotlightSliver({super.key});
  static const mangaSpotlightHeight = 100.0;
  static const mangaSpotlightRatio = 16 / 9;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  color: Colors.black,
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: Sizes.p16),
                        child: BaseNetworkImage(
                          imageUrl: item.panoramaUrl ?? "",
                          fit: BoxFit.cover,
                          width: 100,
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.value.spotlightMangas[index].name ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                                Text(
                                  item.description ?? "",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              )
              .toList(),
          options: CarouselOptions(
            height: 300,
            aspectRatio: 3,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            padEnds: false,
            // autoPlayInterval: const Duration(seconds: 3),
            // autoPlayAnimationDuration: const Duration(milliseconds: 800),
            // autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            scrollDirection: Axis.horizontal,
          ),
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
}
