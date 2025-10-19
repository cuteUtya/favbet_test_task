import 'package:favbet_test_task/features/theme/domain/entities/favbet_app_theme.dart';
import 'package:favbet_test_task/features/theme/domain/repositories/theme_repository.dart';

class FetchThemeUseCase {
  final ThemeRepository repo;

  FetchThemeUseCase(this.repo);

  Future<FavbetAppTheme> call() {
    return repo.fetchCurrentTheme();
  }
}
