import 'package:favbet_test_task/features/movies/domain/entities/movie_summary_entity.dart';
import 'package:favbet_test_task/features/movies/domain/use_cases/fetch_top_rated.dart';
import 'package:favbet_test_task/features/movies/presentation/controllers/movies_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class MoviesTopRatedNotifier extends StateNotifier<MovieTopRatedState> {
  final FetchTopRatedUseCase getMovies;

  MoviesTopRatedNotifier({required this.getMovies})
    : super(MovieTopRatedState());

  Future<void> loadMovies({bool loadMore = false}) async {
    if (state.isLoading || (!state.hasMore && loadMore)) return;

    final nextPage = loadMore ? state.currentPage + 1 : 1;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final moviesResponse = await getMovies(page: nextPage);

      final moviesList = moviesResponse.results;

      state = state.copyWith(
        movies: loadMore ? [...state.movies, ...moviesList] : moviesList,
        isLoading: false,
        currentPage: nextPage,
        hasMore: moviesList.isNotEmpty,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final fetchTopRatedMoviesProvider = Provider<FetchTopRatedUseCase>((ref) {
  return FetchTopRatedUseCase(ref.watch(movieRepositoryProvider));
});

final movieTopRatedProvider =
    StateNotifierProvider<MoviesTopRatedNotifier, MovieTopRatedState>((ref) {
      return MoviesTopRatedNotifier(
        getMovies: ref.watch(fetchTopRatedMoviesProvider),
      );
    });

class MovieTopRatedState {
  final List<MovieSummaryEntity> movies;
  final bool isLoading;
  final String? error;
  final int currentPage;
  final bool hasMore;

  MovieTopRatedState({
    this.movies = const [],
    this.isLoading = false,
    this.error,
    this.currentPage = 1,
    this.hasMore = true,
  });

  MovieTopRatedState copyWith({
    List<MovieSummaryEntity>? movies,
    bool? isLoading,
    String? error,
    int? currentPage,
    bool? hasMore,
  }) {
    return MovieTopRatedState(
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
