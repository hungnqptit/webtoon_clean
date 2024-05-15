import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webtoon/features/mangas/presentation/homepage_screen/spotlight_recent_sliver/spotlight/spotlight_slivers.dart';
import 'package:webtoon/utils/list_extension.dart';

class SpotlightShimmer extends StatelessWidget {
  const SpotlightShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black26,
      highlightColor: Colors.black12,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...List.filled(3, 0)
                .map((e) {
                  return Container(
                    width: HomeSpotlightSliver.mangaSpotlightHeight /
                        HomeSpotlightSliver.mangaSpotlightRatio,
                    height: HomeSpotlightSliver.mangaSpotlightHeight,
                    color: Colors.black,
                  );
                })
                .toList()
                .separator(
                  (_) => const SizedBox(width: 8.0),
                ),
          ],
        ),
      ),
    );
  }
}
