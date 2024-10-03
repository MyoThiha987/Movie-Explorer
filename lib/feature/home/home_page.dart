import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/feature/providers/fetch_local_movies_usecase_provider.dart';
import 'package:flutter_architecture/feature/providers/sync_movie_usecase_provider.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/model/movie.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsyncValue = ref.watch(fetchPopularMoviesProvider(unit));
    final localMoviesAsyncValue = ref.watch((fetchLocalMoviesProvider(unit)));

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Movies',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.1),
              radius: 20,
              child: IconButton(
                iconSize: 24,
                onPressed: () {
                  GoRouter.of(context).pushNamed('search');
                },
                icon: const Icon(Icons.search),
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: moviesAsyncValue.when(data: (isSuccess) {
        print("Success $isSuccess");
        return movieListView(context, isSuccess, localMoviesAsyncValue.value);
      }, error: (error, _) {
        print("$error");
        return movieListView(context, false, localMoviesAsyncValue.value);
        /*return Center(
              child: Text('$error'),
            );*/
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
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
                      fadeOutDuration: const Duration(seconds: 0),
                      fadeInDuration: const Duration(seconds: 0),
                      placeholder: (context, url) => const AspectRatio(
                        aspectRatio: 1,
                        child: BlurHash(hash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                      ),
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

Widget movieListView(BuildContext context, bool isSuccess, HomeMovies? movies) {
  return SingleChildScrollView(
    child: Column(
      children: [
        carouselMovieView(context, movies?.upcomingMovies ?? []),
        const SizedBox(
          height: 16,
        ),
        nowPlayingMoviesView(
            context, movies?.nowPlayingMovies ?? [], "Now Playing Movies"),
        topRatedMoviesView(
            context, movies?.topRatedMovies ?? [], "Top Rated Movies"),
        popularMoviesView(
            context, movies?.popularMovies ?? [], "Popular Movies")
      ],
    ),
  );
}

Widget carouselMovieView(BuildContext context, List<Movie> movies) {
  return CarouselSlider(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const Text('View all',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
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
              return smallMovieItemView(context, movie);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const Text('View all',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
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
              return largeMovieItemView(context, movie);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const Text('View all',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
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
              return mediumMovieItemView(context, movie);
            },
          ),
        )
      ],
    ),
  );
}

Widget smallMovieItemView(BuildContext context, Movie movie) {
  return GestureDetector(
    onTap: () {
      GoRouter.of(context).pushNamed('detail',
          queryParameters: {'movieId': movie.id.toString()});
    },
    child: Container(
      width: MediaQuery.of(context).size.width / 2,
      padding: const EdgeInsets.only(right: 12),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child:  CachedNetworkImage(
                  placeholder: (context, url) => const AspectRatio(
                    aspectRatio: 1.6,
                    child: BlurHash(hash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                  ),
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
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                  )),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget largeMovieItemView(BuildContext context, Movie movie) {
  return GestureDetector(
    onTap: () {
      GoRouter.of(context).pushNamed('detail',
          queryParameters: {'movieId': movie.id.toString()});
    },
    child: Container(
      width: MediaQuery.of(context).size.width / 1.02,
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              placeholder: (context, url) => const AspectRatio(
                aspectRatio: 1.6,
                child: BlurHash(hash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
              ),
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
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget mediumMovieItemView(BuildContext context, Movie movie) {
  return GestureDetector(
    onTap: () {
      GoRouter.of(context).pushNamed('detail',
          queryParameters: {'movieId': movie.id.toString()});
    },
    child: Container(
      width: MediaQuery.of(context).size.width / 1.5,
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(

              placeholder: (context, url) => const AspectRatio(
                aspectRatio: 1.6,
                child: BlurHash(hash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
              ),
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
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ),
  );
}

class CustomImageCache extends WidgetsFlutterBinding {
  @override
  ImageCache createImageCache() {
    ImageCache imageCache = super.createImageCache();
    // Set your image cache size
    imageCache.maximumSizeBytes = 1024 * 1024 * 100; // 100 MB
    return imageCache;
  }
}
