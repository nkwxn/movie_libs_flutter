import 'package:flutter/material.dart';
import 'package:movie_libs/features/genre_list/genre_list_model.dart';
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
      // body: buildGridView(),
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

class MovieCard extends StatelessWidget {
  MovieCard({
    Key? key,
    required Movie movie,
  })  : _movie = movie,
        _genreNames =
            MovieDataHelper.getGenreNames(withGenreIDs: movie.genreIDs),
        super(key: key);

  final Movie _movie;
  final List<String> _genreNames;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15.0),
              bottomLeft: Radius.circular(15.0),
            ),
            child: Image.network(
                MovieDataHelper.getImageURL(path: _movie.posterPath ?? '')),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _movie.title,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (String genre in _genreNames)
                          Container(
                            padding: EdgeInsets.all(4),
                            color: Theme.of(context).colorScheme.background,
                            child: Text(
                              genre.toUpperCase(),
                              style: textTheme.labelSmall,
                            ),
                          )
                      ],
                    ),
                  ),
                  Text(
                    _movie.overview,
                    maxLines: 3,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
