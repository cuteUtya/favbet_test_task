import 'package:favbet_test_task/features/theme/data/data_sources/theme_local_datasource.dart';
import 'package:favbet_test_task/features/theme/data/repository/theme_repository_impl.dart';
import 'package:favbet_test_task/features/theme/domain/data_sources/theme_datasource.dart';
import 'package:favbet_test_task/features/theme/domain/entities/favbet_app_theme.dart';
import 'package:favbet_test_task/features/theme/domain/repositories/theme_repository.dart';
import 'package:favbet_test_task/features/theme/domain/use_cases/fetch_theme.dart';
import 'package:favbet_test_task/features/theme/domain/use_cases/toggle_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class ThemeNotifier extends StateNotifier<ThemeState> {
  final FetchThemeUseCase fetchThemeUseCase;
  final ToggleThemeUseCase toggleThemeUseCase;

  ThemeNotifier(this.fetchThemeUseCase, this.toggleThemeUseCase)
    : super(ThemeState(false, light)) {
    _load();
  }

  Future<void> _load() async {
    var current = await fetchThemeUseCase();
    state = state.copyWith(isDark: current.isDark, theme: current);
  }

  Future<void> toggleTheme() async {
    await toggleThemeUseCase();
    await _load();
  }
}

final themeLocalDatasourceProvider = Provider<ThemeDatasource>(
  (ref) => ThemeLocalDatasource(),
);

final themeRepositoryProvider = Provider<ThemeRepository>(
  (ref) => ThemeRepositoryImpl(ref.watch(themeLocalDatasourceProvider)),
);

final fetchThemeUseCaseProvider = Provider<FetchThemeUseCase>(
  (ref) => FetchThemeUseCase(ref.watch(themeRepositoryProvider)),
);

final toggleThemeUseCaseProvider = Provider<ToggleThemeUseCase>(
  (ref) => ToggleThemeUseCase(ref.watch(themeRepositoryProvider)),
);

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier(
    ref.watch(fetchThemeUseCaseProvider),
    ref.watch(toggleThemeUseCaseProvider),
  );
});

class ThemeState {
  final bool isDark;
  final FavbetAppTheme theme;

  ThemeState(this.isDark, this.theme);

  ThemeState copyWith({bool? isDark, FavbetAppTheme? theme}) =>
      ThemeState(isDark ?? this.isDark, theme ?? this.theme);
}
