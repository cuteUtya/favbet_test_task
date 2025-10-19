// While SharedPreferences is loading, we need a temporary place to store data.
// This could be an in-memory cache that later syncs with SharedPreferences.
// However, for this test task, implementing that is unnecessary,
// so this logic is just a dummy that doesn't persist anywhere.

import 'package:favbet_test_task/features/movies/domain/data_sources/movies_local_datasource.dart';

class MoviesCacheDatasource extends MoviesLocalDatasource {
  @override
  Future<List<String>> getFavoriteIds() async {
    return [];
  }

  @override
  Future<bool> isFavorite(String movieId) async {
    return false;
  }

  @override
  Future<void> toggleFavorite(String movieId) async {}
}
