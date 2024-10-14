import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/feature/providers/see_more_movie_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../domain/model/movie.dart';
import '../search/search_page.dart';

class SeeMorePage extends ConsumerStatefulWidget {
  final String movieType;

  const SeeMorePage({super.key, required this.movieType});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SeeMorePageState();
}

class _SeeMorePageState extends ConsumerState<SeeMorePage> {
  final PagingController<int, Movie> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 2,
          title: Text(context.tr(int.parse(widget.movieType) == 1
              ? 'label_now_playing_movies'
              : int.parse(widget.movieType) == 2
                  ? 'label_top_rate_movies'
                  : 'label_popular_movies'))),
      body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SearchMovieListView(
              pagingController: _pagingController,
            ),
          ]),
    );
  }

  Future<void> _fetchMovies(int page) async {
    try {
      final movies = await ref.read(
          fetchSeeMoreMoviesProvider(page, int.parse(widget.movieType)).future);

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
