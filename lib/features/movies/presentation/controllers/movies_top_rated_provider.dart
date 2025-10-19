import 'package:favbet_test_task/features/movies/domain/entities/movies_response_entity.dart';
import 'package:favbet_test_task/features/movies/domain/use_cases/fetch_top_rated.dart';
import 'package:favbet_test_task/features/movies/presentation/controllers/movies_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class MoviesTopRatedNotifier extends StateNotifier<MovieTopRatedState> {
  final FetchTopRatedUseCase getMovies;

  MoviesTopRatedNotifier({required this.getMovies})
    : super(MovieTopRatedState()) {
    loadMovies();
  }

  Future<void> loadMovies({bool loadMore = false}) async {
    if (state.isLoading || (!state.hasMore && loadMore)) return;

    final nextPage = loadMore ? state.currentPage + 1 : 1;

    state = state.copyWith(isLoading: true, error: null);
    try {
      final moviesResponse = await getMovies(page: nextPage);
      final moviePage = moviesResponse;

      state = state.copyWith(
        pages: loadMore ? state.pages + [moviePage] : [moviePage],
        isLoading: false,
        currentPage: nextPage,
        hasMore: moviePage.results.isNotEmpty,
      );
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
  final List<MoviesResponseEntity> pages;
  final bool isLoading;
  final String? error;
  final int currentPage;
  final bool hasMore;

  MovieTopRatedState({
    this.pages = const [],
    this.isLoading = false,
    this.error,
    this.currentPage = 1,
    this.hasMore = true,
  });

  MovieTopRatedState copyWith({
    List<MoviesResponseEntity>? pages,
    bool? isLoading,
    String? error,
    int? currentPage,
    bool? hasMore,
  }) {
    return MovieTopRatedState(
      pages: pages ?? this.pages,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
