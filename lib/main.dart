import 'package:flutter/material.dart';
import 'package:movie_libs/features/genre_list/genre_list_page.dart';
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
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: GenreListPage(),
    );
  }
}