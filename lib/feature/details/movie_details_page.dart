import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/feature/providers/fetch_movie_details_usecase_provider.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MovieDetailsPage extends ConsumerWidget {
  final String movieId;

  const MovieDetailsPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieDetail =
        ref.watch(fetchMovieDetailsProvider(int.tryParse(movieId)!));
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
                          shape: BoxShape.circle
                      ),
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
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: CachedNetworkImage(
                      /*placeholder: (context, url) => const AspectRatio(
                        aspectRatio: 1.0,
                        child: BlurHash(hash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                      ),*/

                      imageUrl:
                          "https://image.tmdb.org/t/p/original/${movieDetail.backdropPath}",
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
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
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
                                          style: TextStyle(
                                              fontSize: 16),
                                        ),
                                        Text('${movieDetail.voteCount}',
                                            style: const TextStyle(
                                                fontSize: 16))
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('🗓️ Release Date',
                                            style: TextStyle(
                                                fontSize: 16)),
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
                                fontSize: 20,

                                fontWeight: FontWeight.bold),
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
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
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
                                            imageUrl:"https://image.tmdb.org/t/p/original/${company.logoPath}",

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
      error: (Object error, _) => Center(
        child: Text('$error'),
      ),
      loading: () => Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
