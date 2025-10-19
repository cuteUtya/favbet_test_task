import 'package:favbet_test_task/features/movies/domain/entities/movie_details_entity.dart';
import 'package:favbet_test_task/features/movies/domain/use_cases/fetch_movie_details.dart';
import 'package:favbet_test_task/features/movies/presentation/controllers/movies_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class MoviesDetailsNotifier extends StateNotifier<MoviesDetailsState> {
  FetchMovieDetailsUseCase fetchMovieDetailsUseCase;

  MoviesDetailsNotifier(this.fetchMovieDetailsUseCase)
    : super(MoviesDetailsState());

  Future<void> openMovie(String id) async {
    state = state.copyWith(loading: true, error: null);

    try {
      var details = await fetchMovieDetailsUseCase(id);
      state = state.copyWith(details: details);
    } catch (_) {
      state = state.copyWith(error: 'Error while loading movie');
    } finally {
      state = state.copyWith(loading: false);
    }
  }
}

final fetchMoviesDetailsUseCaseProvider = Provider<FetchMovieDetailsUseCase>((
  ref,
) {
  final repository = ref.watch(movieRepositoryProvider);
  return FetchMovieDetailsUseCase(repository);
});

final moviesDetailsProvider =
    StateNotifierProvider<MoviesDetailsNotifier, MoviesDetailsState>((ref) {
      return MoviesDetailsNotifier(
        ref.watch(fetchMoviesDetailsUseCaseProvider),
      );
    });

class MoviesDetailsState {
  final MovieDetailsEntity? details;
  final bool loading;
  final String? error;

  MoviesDetailsState({this.details, this.loading = false, this.error});

  MoviesDetailsState copyWith({
    MovieDetailsEntity? details,
    bool? loading,
    String? error,
  }) => MoviesDetailsState(
    details: details ?? this.details,
    loading: loading ?? this.loading,
    error: error,
  );
}
