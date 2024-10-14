import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/feature/providers/favourite_movie_provider.dart';
import 'package:flutter_architecture/feature/providers/home_movie_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import '../../domain/model/movie.dart';

class FavouritePage extends ConsumerStatefulWidget {
  const FavouritePage({super.key});

  @override
  ConsumerState<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends ConsumerState<FavouritePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          title: Text(context.tr('favourite'),
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ),
        body: const MovieGridView());
  }
}

class MovieGridView extends ConsumerWidget {
  const MovieGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteMovies = ref.watch(fetchFavouriteMoviesProvider(unit));
    return favouriteMovies.when(
      data: (data) {
        return data.isEmpty
            ? Center(child: Text(context.tr('label_no_favourite_data')))
            : GridView.builder(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
                itemCount: data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.72,
                    crossAxisCount: 2,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 12),
                itemBuilder: (BuildContext context, int index) {
                  final movie = data[index];
                  return GridMovieItemView(
                    movie: movie,
                  );
                },
              );
      },
      error: (error, stackTrace) => Center(
        child: Text('Error: $error'),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class GridMovieItemView extends ConsumerWidget {
  const GridMovieItemView({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        final movieJson = jsonEncode(movie.toJson());
        GoRouter.of(context)
            .pushNamed('detail', queryParameters: {'movie': movieJson});
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CachedNetworkImage(
                        // Helps with smooth rendering
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
                                color: movie.isFavourite
                                    ? Colors.red
                                    : Colors.white,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: Text(
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                movie.originalTitle,
                maxLines: 1,
              ),
            ),
          )
        ],
      ),
    );
  }
}
