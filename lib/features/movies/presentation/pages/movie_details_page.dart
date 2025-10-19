import 'package:favbet_test_task/features/movies/presentation/controllers/favorite_movies_provider.dart';
import 'package:favbet_test_task/features/movies/presentation/controllers/movies_details_provider.dart';
import 'package:favbet_test_task/features/theme/presentation/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class MovieDetailsPage extends ConsumerStatefulWidget {
  final String movieId;

  const MovieDetailsPage({super.key, required this.movieId});

  @override
  createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends ConsumerState<MovieDetailsPage> {
  late MoviesDetailsNotifier notifier;

  @override
  void initState() {
    notifier = ref.read(moviesDetailsProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifier.openMovie(widget.movieId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    final movieDetails = ref.watch(moviesDetailsProvider);

    final favoriteController = ref.watch(favoritesProvider.notifier);
    final favorite = ref.watch(favoritesProvider);
    final bool isFavorite = favoriteController.isFavorite(widget.movieId);

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        notifier.close();
      },
      child: Scaffold(
        backgroundColor: theme.theme.background,
        appBar: AppBar(
          backgroundColor: theme.theme.background,
          title: Text(
            movieDetails.details?.title ?? 'loading..',
            style: TextStyle(
              color: theme.theme.text,
              fontFamily: theme.theme.mainFont,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.arrow_back_ios, color: theme.theme.text),
          ),
        ),
        body: movieDetails.loading || movieDetails.details == null
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: SafeArea(
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          Spacer(),
                          Flexible(
                            flex: 4,
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(12),
                              child: Image(
                                image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w500/${movieDetails.details!.posterPath}',
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Rating: ${movieDetails.details!.rating}',
                            style: TextStyle(
                              fontFamily: theme.theme.mainFont,
                              color: theme.theme.text,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        movieDetails.details!.overview,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: theme.theme.mainFont,
                          color: theme.theme.text,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            DateFormat('d MMMM yyyy').format(
                              DateTime.parse(movieDetails.details!.releaseDate),
                            ),
                            style: TextStyle(
                              fontFamily: theme.theme.mainFont,
                              fontSize: 12,
                              color: theme.theme.text,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            favoriteController.toggleFavorite(widget.movieId);
                          },
                          style: ButtonStyle(
                            padding: WidgetStatePropertyAll(
                              EdgeInsets.symmetric(vertical: 14),
                            ),
                            backgroundColor: WidgetStatePropertyAll(
                              isFavorite
                                  ? theme.theme.background
                                  : theme.theme.favorite,
                            ),
                            shape: WidgetStatePropertyAll(
                              isFavorite
                                  ? RoundedRectangleBorder(
                                      side: BorderSide(color: theme.theme.text),
                                      borderRadius:
                                          BorderRadiusGeometry.circular(24),
                                    )
                                  : null,
                            ),
                          ),
                          child: Text(
                            isFavorite
                                ? 'Remove from favorites'
                                : 'Add to favorites',
                            style: TextStyle(
                              fontSize: 16,
                              color: isFavorite
                                  ? theme.theme.buttonText2
                                  : theme.theme.buttonText1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
