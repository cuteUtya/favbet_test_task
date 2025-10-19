import 'package:favbet_test_task/features/movies/presentation/controllers/favorite_movies_provider.dart';
import 'package:favbet_test_task/features/movies/presentation/controllers/movies_top_rated_provider.dart';
import 'package:favbet_test_task/features/movies/presentation/widgets/movie_card.dart';
import 'package:favbet_test_task/features/movies/presentation/widgets/pagination_bar.dart';
import 'package:favbet_test_task/features/theme/presentation/controllers/theme_controller.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  createState() => _HomePage();
}

class _HomePage extends ConsumerState<HomePage> {
  int page = 1;
  final ScrollController scrollController = ScrollController();

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final topRatedController = ref.watch(movieTopRatedProvider.notifier);
    final topRated = ref.watch(movieTopRatedProvider);

    final themeController = ref.watch(themeProvider.notifier);
    final theme = ref.watch(themeProvider);

    final favoriteController = ref.watch(favoritesProvider.notifier);
    final favorite = ref.watch(favoritesProvider);

    ref.listen(movieTopRatedProvider, (previous, next) {
      // When loading finishes and we have data for the current page
      // we need to show the user end of the page (position he was before)
      // isn't specifically the best solution here, but fine for test task I think ;D
      if (previous?.isLoading == true &&
          next.isLoading == false &&
          next.pages[page] != null) {
        _scrollToEnd();
      }
    });

    return Scaffold(
      backgroundColor: theme.theme.background,
      appBar: AppBar(
        backgroundColor: theme.theme.background,
        title: Text(
          'Movie',
          style: TextStyle(
            color: theme.theme.text,
            fontFamily: theme.theme.mainFont,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              //TODO
            },
            icon: Icon(Icons.search, color: theme.theme.text),
          ),
          IconButton(
            onPressed: () {
              themeController.toggleTheme();
            },
            icon: Icon(
              theme.isDark ? Icons.dark_mode : Icons.light_mode,
              color: theme.theme.text,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.only(left: 16.5, right: 16.5, bottom: 24),
          child: Column(
            children: [
              topRated.isLoading
                  ? CircularProgressIndicator()
                  : Expanded(
                      child: ListView(
                        controller: scrollController,
                        children: [
                          GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                (topRated.pages[page]?.results.length) ?? 1,
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 0.56,
                                ),

                            itemBuilder: (_, index) {
                              if (topRated.pages[page] == null) {
                                //if current page isn't loaded
                                if (!topRated.isLoading) {
                                  WidgetsBinding.instance.addPostFrameCallback((
                                    _,
                                  ) {
                                    topRatedController.loadMovies(page: page);
                                  });
                                }
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              final item = topRated.pages[page]!.results[index];

                              return MovieCard(
                                key: Key(
                                  'movie-${item.id}-${favoriteController.isFavorite(item.id.toString())}',
                                ),
                                image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w500/${item.posterPath}',
                                ),
                                isFavorite: favoriteController.isFavorite(
                                  item.id.toString(),
                                ),
                                name: item.title,
                                onFavoriteToggle: () => favoriteController
                                    .toggleFavorite(item.id.toString()),
                                rating: item.voteAverage.toString(),
                              );
                            },
                          ),
                          SizedBox(height: 26),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PaginationBar(
                                currentPage: page,
                                totalPages: topRated.totalPages,
                                onTap: (i) {
                                  setState(() => page = i);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
