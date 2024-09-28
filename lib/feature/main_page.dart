import 'package:flutter/material.dart';
import 'package:flutter_architecture/feature/favourite/favourite_page.dart';
import 'package:flutter_architecture/feature/home/home_page.dart';
import 'package:flutter_architecture/feature/settings/setting_page.dart';
import 'package:go_router/go_router.dart';

import 'details/movie_details_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

/*final GlobalKey<NavigatorState> _sectionANavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'favourite');*/

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    routes: <RouteBase>[
      GoRoute(
// The screen to display as the root in the second tab of the
// bottom navigation bar.
        path: '/detail',
        builder: (BuildContext context, GoRouterState state) =>
            const MovieDetailsPage(),
      ),
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
                       HomePage()),
            ],
          ),
          StatefulShellBranch(routes: <RouteBase>[
            GoRoute(
              // The screen to display as the root in the second tab of the
              // bottom navigation bar.
              path: '/favourite',
              builder: (BuildContext context, GoRouterState state) =>
                  const FavouritePage(),
            ),
          ]),
          StatefulShellBranch(routes: <RouteBase>[
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
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashColor: Colors.transparent,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
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
      appBar: AppBar(
        title: const Text('Movies'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.1),
              radius: 24,
              child: IconButton(
                iconSize: 24,
                onPressed: () {},
                icon: const Icon(Icons.search),
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        indicatorColor: Colors.brown.withOpacity(0.2),
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            // initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.favorite), label: "Favourite"),
          NavigationDestination(icon: Icon(Icons.settings), label: "Setting"),
        ],
      ),
    );
  }
}
