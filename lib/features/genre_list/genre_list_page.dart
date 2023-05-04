import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_libs/helpers/models/genre_list_model.dart';
import 'package:movie_libs/features/movies_list/movies_list_page.dart';
import 'package:movie_libs/helpers/networking/error_model.dart';
import 'package:movie_libs/helpers/networking/movie_data_helper.dart';
import 'package:movie_libs/helpers/reusable_views/error_screen.dart';

class GenreListPage extends StatefulWidget {
  static String routeName = '/';

  const GenreListPage({super.key});

  @override
  State<GenreListPage> createState() => _GenreListPageState();
}

class _GenreListPageState extends State<GenreListPage> {
  List<Genre> _genres = [];
  TMDBError? _error;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadGenres();
  }

  void loadGenres() async {
    dynamic loadedData = await MovieDataHelper.getGenreList();
    setState(() {
      try {
        _genres = loadedData;
      } catch (error) {
        _error = loadedData;
      }
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Genres')),
      body: isLoading
          ? SpinKitFadingCircle(
              color: Theme.of(context).colorScheme.primary,
              size: 50.0,
            )
          : _error != null
              ? ErrorScreen(error: _error!)
              : buildListView(),
    );
  }

  ListView buildListView() => ListView.builder(
        itemCount: _genres.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(_genres[index].name),
          onTap: () {
            // Redirect to Movie list with a respective genre
            Navigator.pushNamed(
              context,
              MoviesListPage.routeName,
              arguments: _genres[index],
            );
          },
        ),
      );
}
