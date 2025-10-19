import 'package:favbet_test_task/features/movies/domain/data_sources/movies_local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoviesLocalDataSourceImpl implements MoviesLocalDatasource {
  SharedPreferences prefs;

  MoviesLocalDataSourceImpl(this.prefs);

  @override
  Future<List<String>> getFavoriteIds() async {
    return (await SharedPreferences.getInstance()).getStringList(
          'movie-favorite-array',
        ) ??
        [];
  }

  @override
  Future<void> toggleFavorite(String movieId) async {
    bool oldValue = await isFavorite(movieId);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('movie-$movieId', !oldValue);

    var oldList = await getFavoriteIds();

    //remove is it was liked before
    if (oldValue) {
      oldList.remove(movieId);
    } else {
      oldList.add(movieId);
    }

    await prefs.setStringList('movie-favorite-array', oldList);
  }

  @override
  Future<bool> isFavorite(String movieId) async {
    bool? value = (await SharedPreferences.getInstance()).getBool(
      'movie-$movieId',
    );

    return value ?? false;
  }
}
