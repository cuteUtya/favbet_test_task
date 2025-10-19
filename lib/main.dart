import 'dart:async';

import 'package:favbet_test_task/features/movies/presentation/pages/home_page.dart';
import 'package:favbet_test_task/features/movies/presentation/pages/movie_details_page.dart';
import 'package:favbet_test_task/features/movies/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await dotenv.load(fileName: ".env");
      runApp(ProviderScope(child: const MyApp()));
    },
    (_, __) {
      //data collections
    },
  );
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/movie/:movieId',
      builder: (BuildContext context, GoRouterState state) {
        return MovieDetailsPage(movieId: state.pathParameters['movieId']!);
      },
    ),
    GoRoute(
      path: '/location',
      builder: (BuildContext context, GoRouterState state) {
        return SearchPage();
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Favbet Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
