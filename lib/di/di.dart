import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/network/connection_checker.dart';
import 'package:flutter_architecture/data/datasource/local/local_source/movie_local_datasource.dart';
import 'package:flutter_architecture/data/datasource/local/local_source/movie_local_datasource_impl.dart';
import 'package:flutter_architecture/data/datasource/network/dio/dio_factory.dart';
import 'package:flutter_architecture/data/datasource/network/network_source/network_datasource.dart';
import 'package:flutter_architecture/data/datasource/network/service/movie_service.dart';
import 'package:flutter_architecture/data/datasource/repository/movie_repository_impl.dart';
import 'package:flutter_architecture/domain/repository/movie_repository.dart';
import 'package:flutter_architecture/domain/usecase/fetch_favourite_movies_usecase.dart';
import 'package:flutter_architecture/domain/usecase/fetch_movies_usecase.dart';
import 'package:flutter_architecture/domain/usecase/fetch_now_playing_movie_usecase.dart';
import 'package:flutter_architecture/domain/usecase/fetch_popular_movie_usecase.dart';
import 'package:flutter_architecture/domain/usecase/fetch_top_rate_movie_usecase.dart';
import 'package:flutter_architecture/domain/usecase/sync_movie_usecase.dart';
import 'package:flutter_architecture/domain/usecase/update_movie_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/datasource/local/enitiy/movie_entity.dart';
import '../data/datasource/network/network_source/network_datasource_impl.dart';
import '../domain/usecase/fetch_movie_details_usecase.dart';
import '../domain/usecase/search_movies_usecase.dart';

GetIt instance = GetIt.instance;

Future<void> initAppModule() async {
  instance.registerLazySingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());

  instance.registerLazySingleton<DioFactory>(() => DioFactory());
  final dio = await instance<DioFactory>().provideDio();

  instance.registerLazySingleton<MovieService>(() => MovieService(dio));

  instance.registerLazySingleton<ConnectionChecker>(() =>
      ConnectionCheckerImpl(internetConnectionChecker: InternetConnection()));

  instance.registerLazySingleton<NetworkDatasource>(
      () => NetworkDatasourceImpl(service: instance()));

  instance.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(movieBox: Hive.box("movies")));

  instance.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(
      networkDataSource: instance(),
      connectionChecker: instance(),
      localDataSource: instance()));

  instance.registerLazySingleton<SyncMovieUseCase>(
      () => SyncMovieUseCase(instance()));

  instance.registerLazySingleton<FetchMoviesUseCase>(
      () => FetchMoviesUseCase(instance()));

  instance.registerLazySingleton<FetchMovieDetailsUseCase>(
      () => FetchMovieDetailsUseCase(instance()));

  instance.registerLazySingleton<SearchMoviesUseCase>(
      () => SearchMoviesUseCase(instance()));

  instance.registerLazySingleton<UpdateMovieUseCase>(
      () => UpdateMovieUseCase(instance()));

  instance.registerLazySingleton<FetchFavouriteMoviesUseCase>(
      () => FetchFavouriteMoviesUseCase(instance()));

  instance.registerLazySingleton<FetchNowPlayingMovieUseCase>(
      () => FetchNowPlayingMovieUseCase(instance()));

  instance.registerLazySingleton<FetchTopRateMovieUseCase>(
      () => FetchTopRateMovieUseCase(instance()));

  instance.registerLazySingleton<FetchPopularMovieUseCase>(
      () => FetchPopularMovieUseCase(instance()));
}
