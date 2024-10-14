import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/domain/model/movie.dart';
import 'package:flutter_architecture/feature/providers/home_movie_provider.dart';
import 'package:flutter_architecture/feature/providers/search_movie_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shimmer/shimmer.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  final PagingController<int, Movie> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  Widget build(BuildContext context) {
    ref.listen(
      searchTextProvider,
      (previous, next) {
        _pagingController.refresh();
      },
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(context.tr('label_search')),
      ),
      body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MovieSearchBar(
                searchController: searchController,
                pagingController: _pagingController),
            SearchMovieListView(
              pagingController: _pagingController,
            ),
          ]),
    );
  }

  Future<void> _fetchMovies(int page) async {
    final query = ref.watch(searchTextProvider);
    if (query.isEmpty) {
      _pagingController.appendLastPage([]);
      return;
    }

    try {
      final movies = await ref.read(searchMoviesProvider(
              SearchMovieRequestParams(page: page, query: query))
          .future);

      final isLastPage = movies.length < 20; // Assuming 20 is the page size
      if (isLastPage) {
        _pagingController.appendLastPage(movies);
      } else {
        _pagingController.appendPage(movies, page + 1);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((page) {
      _fetchMovies(page);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
    searchController.dispose();
  }
}

class SearchMovieListView extends StatelessWidget {
  const SearchMovieListView({super.key, required this.pagingController});

  final PagingController<int, Movie> pagingController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: PagedGridView<int, Movie>(
            padding: const EdgeInsets.all(16),
            showNewPageProgressIndicatorAsGridChild: false,
            showNewPageErrorIndicatorAsGridChild: false,
            showNoMoreItemsIndicatorAsGridChild: false,
            pagingController: pagingController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.8,
              crossAxisSpacing: 12,
              mainAxisSpacing: 0,
              crossAxisCount: 2,
            ),
            builderDelegate: PagedChildBuilderDelegate<Movie>(
              animateTransitions: true,
              transitionDuration: const Duration(milliseconds: 500),

              itemBuilder: (context, item, index) => SearchMovieItemView(
                movie: item,
              ),
              firstPageErrorIndicatorBuilder: (context) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(context.tr('label_general_error'),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          pagingController.refresh();
                        },
                        child: Text(context.tr('label_try_again')))
                  ],
                ),
              ),
              firstPageProgressIndicatorBuilder: (_) => const SizedBox(
                  width: 60,
                  height: 60,
                  child: Center(
                    child: CircularProgressIndicator(),
                  )),

              newPageProgressIndicatorBuilder: (_) => const SizedBox(
                  width: 60,
                  height: 60,
                  child: Center(
                    child: CircularProgressIndicator(),
                  )),
              noItemsFoundIndicatorBuilder: (_) => SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(context.tr('label_no_search_data')),
                  )),
              //noMoreItemsIndicatorBuilder: (_) => NoMoreItemsIndicator(),
            )));
  }
}

class SearchMovieItemView extends ConsumerWidget {
  const SearchMovieItemView({
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
            padding: const EdgeInsets.only(top: 0, bottom: 6),
            child: ClipRRect(
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
                          height: 190.0,
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
                    height: 190,
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
                            color:
                                movie.isFavourite ? Colors.red : Colors.white,
                          )),
                    ),
                  )
                ],
              ),
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

class MovieSearchBar extends ConsumerWidget {
  const MovieSearchBar(
      {super.key,
      required this.searchController,
      required this.pagingController});

  final PagingController<int, Movie> pagingController;

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 50,
          child: TextField(
            controller: searchController,
            onChanged: (text) {
              ref.read(searchTextProvider.notifier).updateSearchText(text);
            },
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: context.tr('hint_search'),
              filled: true,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
