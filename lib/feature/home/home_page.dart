import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/feature/providers/home_movie_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../domain/model/movie.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    ref.read(syncHomeMoviesProvider(unit));
  }

  @override
  Widget build(BuildContext contextX) {
    final moviesAsyncValue = ref.watch(fetchHomeMoviesProvider(unit));

    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          title: Text(context.tr('title'),
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: CircleAvatar(
                radius: 20,
                child: IconButton(
                    iconSize: 24,
                    onPressed: () {
                      GoRouter.of(context).pushNamed('search');
                    },
                    icon: const Icon(Icons.search)),
              ),
            )
          ],
        ),
        body: movieListView(context, moviesAsyncValue));
  }
}

List<Widget> carouselView(BuildContext context, List<Movie> movies) {
  return movies
      .map((movie) => Container(
          margin: const EdgeInsets.all(0.0),
          child: Container(
            margin: const EdgeInsets.all(0.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: Stack(
                  children: <Widget>[
                    CachedNetworkImage(
                      placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey,
                          enabled: true,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 3.5,
                            margin: const EdgeInsets.all(0.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.white,
                            ),
                          )),
                      imageUrl:
                          "https://image.tmdb.org/t/p/original/${movie.posterPath}",
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ],
                )),
          )))
      .toList();
}

Widget movieListView(BuildContext context, AsyncValue<List<Movie>> movie) {
  return SingleChildScrollView(
      child: Column(
    children: [
      movie.when(
          data: (data) {
            return Column(
              children: [
                carouselMovieView(context,
                    data.where((movie) => movie.movieType == 0).toList()),
                nowPlayingMoviesView(
                    context,
                    data.where((movie) => movie.movieType == 1).toList(),
                    context.tr('label_now_playing_movies')),
                topRatedMoviesView(
                    context,
                    data.where((movie) => movie.movieType == 2).toList(),
                    context.tr('label_top_rate_movies')),
                popularMoviesView(
                    context,
                    data.where((movie) => movie.movieType == 3).toList(),
                    context.tr('label_popular_movies'))
              ],
            );
          },
          error: (error, _) => Center(
                child: Text('$error'),
              ),
          loading: () {
            return const SizedBox.shrink();
          }),
      movie.isLoading
          ? SizedBox(
              height: MediaQuery.of(context).size.height * 2 / 3,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : const SizedBox.shrink()
    ],
  ));
}

Widget carouselMovieView(BuildContext context, List<Movie> movies) {
  return Padding(
    padding: const EdgeInsets.only(top: 12),
    child: CarouselSlider(
      items: carouselView(context, movies),
      options: CarouselOptions(
        reverse: false,
        initialPage: 0,
        enlargeStrategy: CenterPageEnlargeStrategy.scale,
        height: MediaQuery.of(context).size.height / 3.5,
        enableInfiniteScroll: false,
        autoPlay: false,
        viewportFraction: 0.8,
        enlargeCenterPage: true,
        enlargeFactor: 0.2,
        pageSnapping: true,
      ),
    ),
  );
}

Widget nowPlayingMoviesView(
    BuildContext context, List<Movie> movies, String category) {
  return Padding(
    padding: const EdgeInsets.only(top: 12),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    category,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).pushNamed('see_more',
                        queryParameters: {'movie_type': "1"});
                  },
                  child: Text(context.tr('label_view_all'),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14)),
                )
              ]),
        ),
        SizedBox(
          height: 240,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 12, right: 12),
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return SmallMovieItemView(movie: movie);
            },
          ),
        )
      ],
    ),
  );
}

Widget topRatedMoviesView(
    BuildContext context, List<Movie> movies, String category) {
  return Padding(
    padding: const EdgeInsets.only(top: 12),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    category,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).pushNamed('see_more',
                        queryParameters: {'movie_type': "2"});
                  },
                  child: Text(context.tr('label_view_all'),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14)),
                )
              ]),
        ),
        SizedBox(
          height: 240,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 12, right: 12),
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return LargeMovieItemView(movie: movie);
            },
          ),
        )
      ],
    ),
  );
}

Widget popularMoviesView(
    BuildContext context, List<Movie> movies, String category) {
  return Padding(
    padding: const EdgeInsets.only(top: 12),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    category,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).pushNamed('see_more',
                        queryParameters: {'movie_type': "3"});
                  },
                  child: Text(context.tr('label_view_all'),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14)),
                ),
              ]),
        ),
        SizedBox(
          height: 240,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 12, right: 12),
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return MediumMovieItemView(movie: movie);
            },
          ),
        )
      ],
    ),
  );
}

class SmallMovieItemView extends ConsumerWidget {
  final Movie movie;

  const SmallMovieItemView({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        final movieJson = jsonEncode(movie.toJson());
        GoRouter.of(context)
            .pushNamed('detail', queryParameters: {'movie': movieJson});
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        padding: const EdgeInsets.only(right: 12),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey,
                        enabled: true,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200.0,
                          margin: const EdgeInsets.all(0.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                          ),
                        )),
                    imageUrl:
                        "https://image.tmdb.org/t/p/original/${movie.posterPath}",
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.center,
                    movie.originalTitle,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    shape: BoxShape.circle),
                child: IconButton(
                    iconSize: 32,
                    onPressed: () {
                      ref.read(favouriteMovieProvider(0, movie));
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: movie.isFavourite ? Colors.red : Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LargeMovieItemView extends ConsumerWidget {
  final Movie movie;

  const LargeMovieItemView({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        final movieJson = jsonEncode(movie.toJson());
        GoRouter.of(context)
            .pushNamed('detail', queryParameters: {'movie': movieJson});
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.02,
        padding: const EdgeInsets.only(right: 12),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey,
                        enabled: true,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200.0,
                          margin: const EdgeInsets.all(0.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                          ),
                        )),
                    imageUrl:
                        "https://image.tmdb.org/t/p/original/${movie.backdropPath}",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      textAlign: TextAlign.center,
                      movie.originalTitle,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    shape: BoxShape.circle),
                child: IconButton(
                    iconSize: 32,
                    onPressed: () {
                      ref.read(favouriteMovieProvider(0, movie));
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: movie.isFavourite ? Colors.red : Colors.white,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MediumMovieItemView extends ConsumerWidget {
  final Movie movie;

  const MediumMovieItemView({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        final movieJson = jsonEncode(movie.toJson());
        GoRouter.of(context)
            .pushNamed('detail', queryParameters: {'movie': movieJson});
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        padding: const EdgeInsets.only(right: 12),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey,
                        enabled: true,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200.0,
                          margin: const EdgeInsets.all(0.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                          ),
                        )),
                    imageUrl:
                        "https://image.tmdb.org/t/p/original/${movie.backdropPath}",
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: Text(
                    movie.originalTitle,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    shape: BoxShape.circle),
                child: IconButton(
                    iconSize: 32,
                    onPressed: () {
                      ref.read(favouriteMovieProvider(0, movie));
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: movie.isFavourite ? Colors.red : Colors.white,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
