import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/domain/model/movie.dart';
import 'package:flutter_architecture/feature/providers/fetch_movie_details_provider.dart';
import 'package:flutter_architecture/feature/providers/home_movie_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class MovieDetailsPage extends ConsumerWidget {
  final Movie movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieDetail = ref.watch(fetchMovieDetailsProvider(movie.id));
    return movieDetail.when(
      data: (movieDetail) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                  forceMaterialTransparency: true,
                  foregroundColor: Colors.white,
                  pinned: true,
                  snap: false,
                  floating: false,
                  expandedHeight: 230.0,
                  stretch: true,
                  onStretchTrigger: () async {},
                  stretchTriggerOffset: 250,
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          shape: BoxShape.circle),
                      child: IconButton(
                          iconSize: 28,
                          onPressed: () {
                            context.pop();
                          },
                          icon: const Icon(
                            Icons.chevron_left,
                          )),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
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
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: CachedNetworkImage(
                      placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey,
                          enabled: true,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 230.0,
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
                      height: 230,
                    ),
                  )),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    color: Colors.grey.withOpacity(0.2),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          movieDetail.originalTitle,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: SizedBox(
                            height: 120,
                            child: Card.outlined(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          '⭐ Review',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text('${movieDetail.voteCount}',
                                            style:
                                                const TextStyle(fontSize: 16))
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('🗓️ Release Date',
                                            style: TextStyle(fontSize: 16)),
                                        Text(movieDetail.releaseDate,
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ))
                                      ],
                                    ),
                                    const Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('🕛 Duration',
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                        Text('1hour',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            movieDetail.overview,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Production Companies',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          child: ListView.builder(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 12),
                              scrollDirection: Axis.horizontal,
                              itemCount: movieDetail.productionCompanies.length,
                              itemBuilder: (context, index) {
                                final company =
                                    movieDetail.productionCompanies[index];
                                return Container(
                                  margin: const EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(90),
                                          child: CachedNetworkImage(
                                            cacheManager:
                                                CachedNetworkImageProvider
                                                    .defaultCacheManager,
                                            imageUrl:
                                                "https://image.tmdb.org/t/p/original/${company.logoPath}",
                                            fit: BoxFit.cover,
                                            width: 80,
                                            height: 80,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12, right: 12),
                                          child: Text(
                                            company.name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  )
                ]),
              )
            ],
          ),
        );
      },
      error: (error, _) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$error',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 16,),
              ElevatedButton(
                  onPressed: () {
                    ref.refresh(fetchMovieDetailsProvider(movie.id));
                  },
                  child: Text(context.tr('label_try_again')))
            ],
          ),
        ),
      ),
      loading: () => Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
