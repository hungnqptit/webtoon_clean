import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:webtoon/features/mangas/presentation/homepage_screen/homepage_screen.dart';

part 'app_router.g.dart';

enum AppRoute {
  home,
  account,
  signIn,
}

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (context, state) => const HomepageScreen(),
      ),
    ],
  );
}
