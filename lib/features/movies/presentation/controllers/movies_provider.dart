import 'package:dio/dio.dart';
import 'package:favbet_test_task/features/movies/data/data_sources/movies_local_datasource.dart';
import 'package:favbet_test_task/features/movies/data/data_sources/movies_remote_datasource.dart';
import 'package:favbet_test_task/features/movies/data/repositories/movies_repository_impl.dart';
import 'package:favbet_test_task/features/movies/domain/data_sources/movies_local_datasource.dart';
import 'package:favbet_test_task/features/movies/domain/data_sources/movies_remote_datasource.dart';
import 'package:favbet_test_task/features/movies/domain/repositories/movies_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final prefsProvider = FutureProvider<SharedPreferences>((ref) {
  return SharedPreferences.getInstance();
});

final movieRemoteDataSourceProvider = Provider<MoviesRemoteDatasource>((ref) {
  final dio = ref.watch(dioProvider);
  return MoviesRemoteDatasourceImpl(dio);
});

final movieLocalDataSourceProvider = Provider<MoviesLocalDatasource>((ref) {
  final prefs = ref.watch(prefsProvider);
  return prefs.when(
    data: (prefs) => MoviesLocalDataSourceImpl(prefs),
    loading: () => throw UnimplementedError('SharedPreferences not loaded yet'),
    error: (e, st) => throw e,
  );
});

final movieRepositoryProvider = Provider<MoviesRepository>((ref) {
  return MoviesRepositoryImpl(
    ref.watch(movieRemoteDataSourceProvider),
    ref.watch(movieLocalDataSourceProvider),
  );
});
