import 'package:flutter_architecture/core/network/connection_checker.dart';
import 'package:flutter_architecture/data/datasource/network/dio/dio_factory.dart';
import 'package:flutter_architecture/data/datasource/network/service/movie_service.dart';
import 'package:flutter_architecture/data/datasource/repository/movie_repository_impl.dart';
import 'package:flutter_architecture/domain/repository/movie_repository.dart';
import 'package:flutter_architecture/domain/usecase/fetch_movie_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

GetIt instance = GetIt.instance;

Future<void> initAppModule() async {
  instance.registerLazySingleton<DioFactory>(() => DioFactory());
  final dio = await instance<DioFactory>().provideDio();

  instance.registerLazySingleton<MovieService>(() => MovieService(dio));

  instance.registerLazySingleton<ConnectionChecker>(() =>
      ConnectionCheckerImpl(internetConnectionChecker: InternetConnection()));

  instance.registerLazySingleton<MovieRepository>(() =>
      MovieRepositoryImpl(service: instance(), connectionChecker: instance()));

  instance.registerLazySingleton<FetchMovieUseCase>(
      () => FetchMovieUseCase(instance()));
}
