import 'package:favbet_test_task/features/movies/data/data_sources/movies_local_datasource.dart';
import 'package:favbet_test_task/features/movies/data/data_sources/movies_remote_datasource.dart';
import 'package:favbet_test_task/features/movies/domain/entities/movie_details_entity.dart';
import 'package:favbet_test_task/features/movies/domain/entities/movie_search_responce_entity.dart';
import 'package:favbet_test_task/features/movies/domain/entities/movies_response_entity.dart';
import 'package:favbet_test_task/features/movies/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesRemoteDatasource remote;
  final MovieLocalDataSource local;

  MoviesRepositoryImpl(this.remote, this.local);

  @override
  Future<MoviesResponseEntity> fetchTopRated({int page = 1}) async {
    final model = await remote.fetchTopRated(page: page);
    return model.toEntity();
  }

  @override
  Future<MovieDetailsEntity> fetchMovieDetails(String id) async {
    final model = await remote.fetchMovieDetails(id);
    return model.toEntity();
  }

  @override
  Future<MovieSearchResponceEntity> search(String q, {int page = 1}) async {
    final model = await remote.search(q: q, page: page);
    return model.toEntity();
  }

  @override
  Future<bool> isFavorite(String movieId) {
    return local.isFavorite(movieId);
  }

  @override
  Future<void> toggleFavorite(String movieId) async {
    local.toggleFavorite(movieId);
  }
}
