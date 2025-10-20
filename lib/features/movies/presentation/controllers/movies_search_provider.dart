import 'dart:async';

import 'package:favbet_test_task/features/movies/domain/entities/movie_summary_entity.dart';
import 'package:favbet_test_task/features/movies/domain/use_cases/search_movies.dart';
import 'package:favbet_test_task/features/movies/presentation/controllers/movies_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class MovieSearchNotifier extends StateNotifier<MoviesSearchState> {
  final SearchMoviesUseCase searchUseCase;

  MovieSearchNotifier(this.searchUseCase) : super(MoviesSearchState());

  Timer? _debounce;

  Future<void> search(String q) async {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () async {
      if (q.length <= 3) {
        state = state.copyWith(
          loading: false,
          results: [],
          page: 1,
          totalResults: 0,
        );
        return;
      }
      state = state.copyWith(loading: true, error: null);

      try {
        final results = await searchUseCase(q);
        state = state.copyWith(
          results: results.results,
          totalResults: results.totalResults,
        );
      } catch (_) {
        state = state.copyWith(error: 'Issue while searching movies');
      } finally {
        state = state.copyWith(loading: false);
      }
    });
  }

  void clear() {
    state = state.copyWith(
      loading: false,
      error: null,
      results: [],
      page: 1,
      hasMore: false,
      totalResults: 0,
    );
  }

  Future<void> fetchNextPage(String query) async {
    if (state.loading || !state.hasMore) return;

    final nextPage = state.page + 1;
    state = state.copyWith(loading: true);

    try {
      final results = await searchUseCase(query, page: nextPage);
      state = state.copyWith(
        results: [...state.results, ...results.results],
        page: nextPage,
        loading: false,
        hasMore: results.results.isNotEmpty,
      );
    } catch (_) {
      state = state.copyWith(
        loading: false,
        error: 'Issue while loading next page',
      );
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}

final movieSearchUseCaseProvider = Provider<SearchMoviesUseCase>((ref) {
  return SearchMoviesUseCase(ref.watch(movieRepositoryProvider));
});

final moviesSearchProvider =
    StateNotifierProvider<MovieSearchNotifier, MoviesSearchState>((ref) {
      return MovieSearchNotifier(ref.watch(movieSearchUseCaseProvider));
    });

class MoviesSearchState {
  final bool loading;
  final String? error;
  final int totalResults;
  final List<MovieSummaryEntity> results;
  final int page;
  final bool hasMore;

  MoviesSearchState({
    this.loading = false,
    this.error,
    this.results = const [],
    this.page = 1,
    this.totalResults = 0,
    this.hasMore = true,
  });

  MoviesSearchState copyWith({
    bool? loading,
    String? error,
    List<MovieSummaryEntity>? results,
    int? page,
    bool? hasMore,
    int? totalResults,
  }) {
    return MoviesSearchState(
      loading: loading ?? this.loading,
      error: error,
      results: results ?? this.results,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      totalResults: totalResults ?? this.totalResults,
    );
  }
}
