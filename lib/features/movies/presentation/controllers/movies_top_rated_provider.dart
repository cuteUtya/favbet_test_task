import 'package:favbet_test_task/features/movies/domain/entities/movies_response_entity.dart';
import 'package:favbet_test_task/features/movies/domain/use_cases/fetch_top_rated.dart';
import 'package:favbet_test_task/features/movies/presentation/controllers/movies_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class MoviesTopRatedNotifier extends StateNotifier<MovieTopRatedState> {
  final FetchTopRatedUseCase getMovies;

  MoviesTopRatedNotifier({required this.getMovies})
    : super(MovieTopRatedState());

  Future<void> loadMovies({required int page}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final moviesResponse = await getMovies(page: page);
      final newPages = <int, MoviesResponseEntity>{};

      newPages.addAll(state.pages);
      newPages[page] = moviesResponse;

      if (mounted) {
        state = state.copyWith(
          pages: newPages,
          isLoading: false,
          totalPages: moviesResponse.totalPages,
        );
      }
    } catch (e) {
      if (mounted) {
        state = state.copyWith(isLoading: false, error: e.toString());
      }
    } finally {
      if (mounted) {
        state = state.copyWith(isLoading: false);
      }
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
  final Map<int, MoviesResponseEntity> pages;
  final bool isLoading;
  final String? error;
  final int totalPages;

  MovieTopRatedState({
    this.pages = const {},
    this.isLoading = false,
    this.error,
    this.totalPages = 1,
  });

  MovieTopRatedState copyWith({
    Map<int, MoviesResponseEntity>? pages,
    bool? isLoading,
    String? error,
    int? totalPages,
  }) {
    return MovieTopRatedState(
      pages: pages ?? this.pages,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      totalPages: totalPages ?? this.totalPages,
    );
  }
}
