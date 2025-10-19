import 'package:shared_preferences/shared_preferences.dart';

class MovieLocalDataSource {
  MovieLocalDataSource();

  Future<void> toggleFavorite(String movieId) async {
    bool oldValue = await isFavorite(movieId);

    (await SharedPreferences.getInstance()).setBool(
      'movie-$movieId',
      !oldValue,
    );
  }

  Future<bool> isFavorite(String movieId) async {
    bool? value = (await SharedPreferences.getInstance()).getBool(
      'movie-$movieId',
    );

    return value ?? false;
  }
}
