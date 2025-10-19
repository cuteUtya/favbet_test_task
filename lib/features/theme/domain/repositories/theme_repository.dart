import 'package:favbet_test_task/features/theme/domain/entities/favbet_app_theme.dart';

abstract class ThemeRepository {
  Future<FavbetAppTheme> fetchCurrentTheme();
  Future<void> toggleTheme();
}
