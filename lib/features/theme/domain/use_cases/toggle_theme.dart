import 'package:favbet_test_task/features/theme/domain/repositories/theme_repository.dart';

class ToggleThemeUseCase {
  final ThemeRepository repo;

  ToggleThemeUseCase(this.repo);

  Future<void> call() {
    return repo.toggleTheme();
  }
}
