import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/domain/model/movie.dart';
import 'package:flutter_architecture/feature/providers/search_movie_usecase_provider.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../providers/update_search_textfield_provider.dart';

class SearchPage extends ConsumerStatefulWidget {
  SearchPage({super.key});

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
            showNewPageProgressIndicatorAsGridChild: false,
            showNewPageErrorIndicatorAsGridChild: false,
            showNoMoreItemsIndicatorAsGridChild: false,
            pagingController: pagingController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              // childAspectRatio: 100 / 150,
              //crossAxisSpacing: 0,
              //mainAxisSpacing: 50,
              crossAxisCount: 2,
            ),
            builderDelegate: PagedChildBuilderDelegate<Movie>(
              animateTransitions: true,
              transitionDuration: const Duration(milliseconds: 500),

              itemBuilder: (context, item, index) => SearchMovieItemView(
                movie: item,
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
              noItemsFoundIndicatorBuilder: (_) => const SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text("There is no data to show up this time"),
                  )),
              //noMoreItemsIndicatorBuilder: (_) => NoMoreItemsIndicator(),
            )));
  }
}

class SearchMovieItemView extends StatelessWidget {
  const SearchMovieItemView({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                fadeInDuration: const Duration(milliseconds: 50),
                // Helps with smooth rendering
                fadeOutDuration: const Duration(milliseconds: 50),
                placeholder: (context, url) => const AspectRatio(
                  aspectRatio: 1.2,
                  child: BlurHash(hash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                ),
                imageUrl:
                    "https://image.tmdb.org/t/p/original/${movie.backdropPath}",
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: 100,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
          child: Text(
            movie.originalTitle,
            maxLines: 1,
          ),
        )
      ],
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
      padding: const EdgeInsets.all(8.0),
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
