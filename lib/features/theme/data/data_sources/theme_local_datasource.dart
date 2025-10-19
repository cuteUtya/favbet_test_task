import 'dart:ui';

import 'package:favbet_test_task/features/theme/domain/data_sources/theme_datasource.dart';
import 'package:favbet_test_task/features/theme/domain/entities/favbet_app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeLocalDatasource implements ThemeDatasource {
  @override
  Future<FavbetAppTheme> fetchTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final theme = (prefs.getString('app-theme') ?? 'light');

    return theme == 'light' ? light : dark;
  }

  @override
  Future<void> toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final oldValue = prefs.getString('app-theme');
    await prefs.setString(
      'app-theme',
      oldValue == null || oldValue == 'light' ? 'dark' : 'light',
    );
  }
}

final FavbetAppTheme light = FavbetAppTheme(
  mainFont: 'Roboto',
  isDark: false,
  background: Color(0xffFFFFFF),
  buttonBackground1: Color(0xffF2C94C),
  buttonBackground2: Color(0xff111111),
  buttonText1: Color(0xff111111),
  buttonText2: Color(0xff111111),
  favorite: Color(0xffF2C94C),
  search: Color(0xffF1F1F1),
  star: Color.fromARGB(153, 17, 17, 17),
  title: Color(0xffFFFFFF),
  text: Color(0xff111111),
);
final FavbetAppTheme dark = FavbetAppTheme(
  mainFont: 'Roboto',
  isDark: true,
  background: Color(0xff111111),
  buttonBackground1: Color(0xffF2C94C),
  buttonBackground2: Color(0xffFFFFFF),
  buttonText1: Color(0xff111111),
  buttonText2: Color(0xffFFFFFF),
  favorite: Color(0xffF2C94C),
  search: Color(0xff2A2A2A),
  star: Color.fromARGB(153, 17, 17, 17),
  title: Color(0xffFFFFFF),
  text: Color(0xffFFFFFF),
);
