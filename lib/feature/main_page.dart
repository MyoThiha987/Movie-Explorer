import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/domain/model/movie.dart';
import 'package:flutter_architecture/feature/favourite/favourite_page.dart';
import 'package:flutter_architecture/feature/home/home_page.dart';
import 'package:flutter_architecture/feature/providers/setting_theme_provider.dart';
import 'package:flutter_architecture/feature/search/search_page.dart';
import 'package:flutter_architecture/feature/see_more/see_more_page.dart';
import 'package:flutter_architecture/feature/settings/setting_page.dart';
import 'package:flutter_architecture/feature/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'details/movie_details_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

final GlobalKey<NavigatorState> _fav =
    GlobalKey<NavigatorState>(debugLabel: 'fav');

final GlobalKey<NavigatorState> _set =
    GlobalKey<NavigatorState>(debugLabel: 'sett');

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    routes: <RouteBase>[
      GoRoute(
          name: "see_more",
          // The screen to display as the root in the second tab of the
          // bottom navigation bar.
          path: '/see_more',
          builder: (BuildContext context, GoRouterState state) {
            final movieType = state.uri.queryParameters['movie_type']!;
            return SeeMorePage(movieType: movieType);
          }),
      GoRoute(
          name: "detail",
          // The screen to display as the root in the second tab of the
          // bottom navigation bar.
          path: '/detail',
          builder: (BuildContext context, GoRouterState state) {
            final movieJson = state.uri.queryParameters['movie'];
            final movie = Movie.fromJson(jsonDecode(movieJson!));
            return MovieDetailsPage(movie: movie);
          }),
      GoRoute(
          name: "search",
          // The screen to display as the root in the second tab of the
          // bottom navigation bar.
          path: '/search',
          builder: (BuildContext context, GoRouterState state) => SearchPage()),
      // #docregion configuration-builder
      StatefulShellRoute.indexedStack(
        builder: (BuildContext context, GoRouterState state,
            StatefulNavigationShell navigationShell) {
          // Return the widget that implements the custom shell (in this case
          // using a BottomNavigationBar). The StatefulNavigationShell is passed
          // to be able access the state of the shell and to navigate to other
          // branches in a stateful way.
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        // #enddocregion configuration-builder
        // #docregion configuration-branches
        branches: <StatefulShellBranch>[
          // The route branch for the first tab of the bottom navigation bar.
          StatefulShellBranch(
            navigatorKey: _sectionANavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                  // The screen to display as the root in the first tab of the
                  // bottom navigation bar.
                  path: '/home',
                  builder: (BuildContext context, GoRouterState state) =>
                      const HomePage()),
            ],
          ),
          StatefulShellBranch(navigatorKey: _fav, routes: <RouteBase>[
            GoRoute(
              // The screen to display as the root in the second tab of the
              // bottom navigation bar.
              path: '/favourite',
              builder: (BuildContext context, GoRouterState state) =>
                  const FavouritePage(),
            ),
          ]),
          StatefulShellBranch(navigatorKey: _set, routes: <RouteBase>[
            GoRoute(
              // The screen to display as the root in the third tab of the
              // bottom navigation bar.
              path: '/setting',
              builder: (BuildContext context, GoRouterState state) =>
                  const SettingsPage(),
            ),
          ]),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    MaterialTheme theme =
        MaterialTheme(createTextTheme(context, "Lora", "Lora"));
    final themeMode = ref.watch(switchThemeProviderProvider);
    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      themeAnimationStyle: AnimationStyle(
          curve: Curves.easeIn, duration: Duration(milliseconds: 300)),
      themeMode: themeMode,
      darkTheme: theme.dark(),
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: theme.light(),
      //home: const MainPage(),
    );
  }
}

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({required this.navigationShell, Key? key})
      : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        indicatorColor: Colors.brown.withOpacity(0.2),
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: [
          NavigationDestination(
              icon: const Icon(Icons.home), label: context.tr('home')),
          NavigationDestination(
              icon: const Icon(Icons.favorite), label: context.tr('favourite')),
          NavigationDestination(
              icon: const Icon(Icons.settings), label: context.tr('setting')),
        ],
      ),
    );
  }
}
