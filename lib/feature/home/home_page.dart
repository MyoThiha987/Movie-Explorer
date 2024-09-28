import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/feature/providers/fetch_movie_usecase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/model/movie.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsyncValue = ref.watch(fetchPopularMoviesProvider(1));

    return moviesAsyncValue.when(
        data: (movies) => movieListView(context, movies),
        error: (error, _) {
          return Center(
            child: Text('$error'),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

List<Widget> CarouselView(BuildContext context, List<Movie> movies) {
  return movies
      .map((movie) => Container(
          margin: const EdgeInsets.all(0.0),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 0.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(
                        'https://image.tmdb.org/t/p/original/${movie.posterPath}',
                        fit: BoxFit.cover,
                        width:  MediaQuery.of(context).size.width),
                  ],
                )),
          )))
      .toList();
}

Widget movieListView(BuildContext context, List<Movie> movies) {
  return SingleChildScrollView(
    child: Column(
      children: [
        CarouselSlider(
          items: CarouselView(context, movies),
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
        const SizedBox(
          height: 16,
        ),
        PopularMoviesView(context, movies),
        PopularMoviesView(context, movies),
        PopularMoviesView(context, movies)
      ],
    ),
  );
}

Widget nowPlayingMovieView() {
  final List<String> names = ["A", "B", "C"];
  return SizedBox(
    height: 100,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: names.length,
        itemBuilder: (context, index) {
          return smallMovieItemView(context: context, name: names[index]);
        }),
  );
}

Widget PopularMoviesView(BuildContext context, List<Movie> movies) {
  return Padding(
    padding: const EdgeInsets.only(top: 12),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(12),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Popular Movies',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                Text('View all',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))
              ]),
        ),
        SizedBox(
          height: 240,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 12,right: 12),
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return SmallMovieItemView(context, movie);
            },
          ),
        )
      ],
    ),
  );
}

Widget SmallMovieItemView(BuildContext context, Movie movie) {
  return GestureDetector(
    onTap: () {
      GoRouter.of(context).push("/detail");
    },
    child: Container(
      width: MediaQuery.of(context).size.width / 2,
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              "https://image.tmdb.org/t/p/original/${movie.posterPath}",
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: 200,
            ),
          ),
          const SizedBox(height: 12,),
          Expanded(
            child: Text(
              movie.originalTitle,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget smallMovieItemView(
    {required BuildContext context, required String name}) {
  return InkWell(
    onTap: () {
      GoRouter.of(context).push("/detail");
    },
    child: Container(
        width: 150,
        height: 100,
        margin: EdgeInsets.only(left: 12, right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.black.withOpacity(0.2),
        ),
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Text(name)),
  );
}
