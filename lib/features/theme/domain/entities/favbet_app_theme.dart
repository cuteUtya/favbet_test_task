import 'dart:ui';

class FavbetAppTheme {
  final bool isDark;
  final Color background;
  final Color text;
  final Color favorite;
  final Color title;
  final Color star;
  final Color buttonBackground1;
  final Color buttonText1;
  final Color buttonBackground2;
  final Color buttonText2;
  final Color search;
  final String mainFont;

  FavbetAppTheme({
    required this.isDark,
    required this.background,
    required this.buttonBackground1,
    required this.buttonBackground2,
    required this.buttonText1,
    required this.buttonText2,
    required this.favorite,
    required this.search,
    required this.star,
    required this.title,
    required this.text,
    required this.mainFont,
  });
}
