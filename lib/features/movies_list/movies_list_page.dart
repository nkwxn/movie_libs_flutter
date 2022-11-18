import 'package:flutter/material.dart';
import 'package:movie_libs/features/genre_list/models/genre_list_model.dart';
import 'package:movie_libs/features/movies_list/movies_list_model.dart';
import 'package:movie_libs/helpers/networking/error_model.dart';
import 'package:movie_libs/helpers/networking/movie_data_helper.dart';

class MoviesListPage extends StatefulWidget {
  static String routeName = '/movie_list';
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
    // TODO: implement initState
    super.initState();
    getMovieList();
  }

  void getMovieList() async {
    final moviesResp =
        await MovieDataHelper.getMovieList(genreId: widget.genre.id);
    print(moviesResp);
    setState(() {
      try {
        MovieListResponse resp = moviesResp;
        _movieList = resp.results;
      } catch (error) {
        _error = moviesResp;
        print(_error!.success);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.genre.name)),
      body: buildListView(),
    );
  }

// Text(_movieList[index].title)
  ListView buildListView() {
    return ListView.builder(
      // padding: EdgeInsets.all(10.0),
      itemCount: _movieList.length,
      itemBuilder: (context, index) => SizedBox(
        height: 100,
        child: ListTile(
          leading: Image.network(MovieDataHelper.getImageURL(
              path: _movieList[index].posterPath ?? '')),
        ),
      ),
    );
  }

// Only apply this when orientation is vertical
  GridView buildGridView() {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) => Container(),
    );
  }
}
