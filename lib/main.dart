import 'package:flutter/material.dart';
import 'package:movie_libs/features/genre_list/genre_list_page.dart';
import 'package:movie_libs/features/genre_list/genre_list_model.dart';
import 'package:movie_libs/features/movies_list/movies_list_page.dart';
import 'package:movie_libs/helpers/themes/color_schemes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        scaffoldBackgroundColor: lightColorScheme.background
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        scaffoldBackgroundColor: darkColorScheme.background
      ),
      initialRoute: GenreListPage.routeName,
      routes: {
        GenreListPage.routeName: (context) => const GenreListPage(),
        MoviesListPage.routeName: (context) {
          Genre genreArgs = ModalRoute.of(context)!.settings.arguments as Genre;
          return MoviesListPage(
            genre: genreArgs,
          );
        },
      },
    );
  }
}
