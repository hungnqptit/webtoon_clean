import 'package:flutter/material.dart';

import 'package:webtoon/common/responsive_center.dart';
import 'package:webtoon/constants/app_sizes.dart';

class HomeHeaderSliver extends StatelessWidget {
  const HomeHeaderSliver({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveSliverCenter(
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
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
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
    );
  }
}
