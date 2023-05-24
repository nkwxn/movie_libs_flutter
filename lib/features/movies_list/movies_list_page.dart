import 'package:flutter/material.dart';
import 'package:movie_libs/helpers/models/movies_list_model.dart';
import 'package:movie_libs/helpers/models/genre_list_model.dart';
import 'package:movie_libs/features/movies_list/view_components/movie_card.dart';
import 'package:movie_libs/helpers/networking/error_model.dart';
import 'package:movie_libs/helpers/networking/movie_data_helper.dart';

class MoviesListPage extends StatefulWidget {
  static String routeName = '/movies_list';
  final Genre genre;

  const MoviesListPage({super.key, required this.genre});

  @override
  State<MoviesListPage> createState() => _MoviesListPageState();
}

class _MoviesListPageState extends State<MoviesListPage> {
  List<Movie> _movieList = [];
  TMDBError? _error;

  @override
  void initState() {
    super.initState();
    getMovieList();
  }

  void getMovieList() async {
    final moviesResp =
        await MovieDataHelper.getMovieList(genreId: widget.genre.id);
    setState(() {
      try {
        MovieListResponse resp = moviesResp;
        _movieList = resp.results;
      } catch (error) {
        _error = moviesResp;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.genre.name)),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? buildListView()
              : buildGridView();
        },
      ),
    );
  }

  ListView buildListView() {
    return ListView.builder(
      padding: MediaQuery.of(context).padding.copyWith(top: 5.0),
      itemCount: _movieList.length,
      itemBuilder: (context, index) => SizedBox(
        height: 200,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5.0,
          ),
          child: MovieCard(movie: _movieList[index]),
        ),
      ),
    );
  }

// Only apply this when orientation is vertical
  Widget buildGridView() {
    return SafeArea(
      bottom: false,
      child: GridView.builder(
        padding: MediaQuery.of(context).padding.copyWith(left: 10, right: 10),
        itemCount: _movieList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) => MovieCard(movie: _movieList[index]),
      ),
    );
  }
}