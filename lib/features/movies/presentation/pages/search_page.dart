import 'package:favbet_test_task/features/movies/presentation/controllers/favorite_movies_provider.dart';
import 'package:favbet_test_task/features/movies/presentation/controllers/movies_search_provider.dart';
import 'package:favbet_test_task/features/movies/presentation/widgets/movie_card.dart';
import 'package:favbet_test_task/features/theme/presentation/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  TextEditingController editingController = TextEditingController();
  late MovieSearchNotifier moviesSearchController;

  @override
  void initState() {
    super.initState();
    moviesSearchController = ref.read(moviesSearchProvider.notifier);

    editingController.addListener(() {
      moviesSearchController.search(editingController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    final searchResults = ref.watch(moviesSearchProvider);

    final favoriteController = ref.watch(favoritesProvider.notifier);
    final favorite = ref.watch(favoritesProvider);

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        moviesSearchController.clear();
      },
      child: Scaffold(
        backgroundColor: theme.theme.background,
        appBar: AppBar(
          backgroundColor: theme.theme.background,
          title: Text(
            'Search',
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
        body: Padding(
          padding: EdgeInsetsGeometry.only(left: 16, right: 16, top: 16),
          child: SafeArea(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels >=
                        scrollInfo.metrics.maxScrollExtent - 500 &&
                    !searchResults.loading &&
                    searchResults.hasMore) {
                  moviesSearchController.fetchNextPage(editingController.text);
                  return true;
                }
                return false;
              },
              child: ListView(
                children: [
                  TextField(
                    controller: editingController,
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: theme.theme.text,
                      fontFamily: theme.theme.mainFont,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Movie',
                      contentPadding: EdgeInsets.all(16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: theme.theme.search,
                      prefixIcon: Icon(Icons.search, color: theme.theme.text),
                    ),
                  ),
                  SizedBox(height: 16),
                  if (!searchResults.loading &&
                      editingController.text.isNotEmpty)
                    Padding(
                      padding: EdgeInsetsGeometry.only(bottom: 24),
                      child: Text(
                        'Search results (${searchResults.totalResults})',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: theme.theme.text,
                          fontFamily: theme.theme.mainFont,
                        ),
                      ),
                    ),

                  if (!searchResults.loading &&
                      editingController.text.isNotEmpty &&
                      searchResults.totalResults == 0)
                    Icon(Icons.not_interested, size: 100),
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: searchResults.results.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.56,
                    ),
                    itemBuilder: (_, index) {
                      final item = searchResults.results[index];
                      return MovieCard(
                        key: Key(
                          'movie-${item.id}-${favoriteController.isFavorite(item.id.toString())}',
                        ),
                        id: item.id.toString(),
                        imagePath: item.posterPath,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
