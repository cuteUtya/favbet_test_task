import 'package:flutter_dotenv/flutter_dotenv.dart';

String get movieKey {
  var key = dotenv.env['MOVIE_API_KEY'];

  if (key == null) {
    throw Exception('MOVIE_API_KEY is not provided');
  }

  return key;
}

String get movieApiHost {
  return dotenv.env['MOVIE_API_HOST']!;
}
