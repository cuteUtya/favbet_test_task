abstract class MoviesLocalDatasource {
  Future<List<String>> getFavoriteIds();
  Future<void> toggleFavorite(String movieId);
  Future<bool> isFavorite(String movieId);
}
