import 'package:favbet_test_task/features/theme/domain/entities/favbet_app_theme.dart';

abstract class ThemeDatasource {
  Future<void> toggleTheme();
  Future<FavbetAppTheme> fetchTheme();
}
