import 'package:favbet_test_task/features/theme/domain/data_sources/theme_datasource.dart';
import 'package:favbet_test_task/features/theme/domain/entities/favbet_app_theme.dart';
import 'package:favbet_test_task/features/theme/domain/repositories/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeDatasource local;

  ThemeRepositoryImpl(this.local);
  @override
  Future<FavbetAppTheme> fetchCurrentTheme() {
    return local.fetchTheme();
  }

  @override
  Future<void> toggleTheme() {
    return local.toggleTheme();
  }
}
