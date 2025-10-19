import 'package:favbet_test_task/features/movies/presentation/controllers/movies_top_rated_provider.dart';
import 'package:favbet_test_task/features/theme/presentation/controllers/theme_controller.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  createState() => _HomePage();
}

class _HomePage extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final topRated = ref.watch(movieTopRatedProvider);
    final themeController = ref.watch(themeProvider.notifier);
    final theme = ref.watch(themeProvider);

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
        child: Column(
          children: [
            topRated.isLoading
                ? CircularProgressIndicator()
                : Text('loaded: ${topRated.pages.length}'),
          ],
        ),
      ),
    );
  }
}
