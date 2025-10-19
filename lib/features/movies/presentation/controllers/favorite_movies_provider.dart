import 'package:favbet_test_task/features/movies/domain/use_cases/get_favorite_ids.dart';
import 'package:favbet_test_task/features/movies/domain/use_cases/toggle_favorite.dart';
import 'package:favbet_test_task/features/movies/presentation/controllers/movies_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class FavoritesNotifier extends StateNotifier<FavoritesState> {
  final GetFavoriteIdsUseCase getFavorites;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  FavoritesNotifier({
    required this.getFavorites,
    required this.toggleFavoriteUseCase,
  }) : super(FavoritesState()) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final ids = await getFavorites();
    state = state.copyWith(favoriteIds: ids);
  }

  Future<void> toggleFavorite(String movieId) async {
    await toggleFavoriteUseCase(movieId);
    final ids = await getFavorites();
    state = state.copyWith(favoriteIds: ids);
  }

  bool isFavorite(String movieId) => state.favoriteIds.contains(movieId);
}

final getFavoriteIdsUseCaseProvider = Provider<GetFavoriteIdsUseCase>((ref) {
  final repository = ref.watch(movieRepositoryProvider);
  return GetFavoriteIdsUseCase(repository);
});

final toggleFavoriteUseCaseProvider = Provider<ToggleFavoriteUseCase>((ref) {
  final repository = ref.watch(movieRepositoryProvider);
  return ToggleFavoriteUseCase(repository);
});

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, FavoritesState>((ref) {
      final getFavorites = ref.watch(getFavoriteIdsUseCaseProvider);
      final toggleFavorite = ref.watch(toggleFavoriteUseCaseProvider);
      return FavoritesNotifier(
        getFavorites: getFavorites,
        toggleFavoriteUseCase: toggleFavorite,
      );
    });

class FavoritesState {
  final List<String> favoriteIds;

  FavoritesState({this.favoriteIds = const []});

  FavoritesState copyWith({List<String>? favoriteIds}) {
    return FavoritesState(favoriteIds: favoriteIds ?? this.favoriteIds);
  }
}
