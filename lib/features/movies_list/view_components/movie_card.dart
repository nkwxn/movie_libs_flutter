import 'package:flutter/material.dart';
import 'package:movie_libs/features/movie_detail/movie_detail_page.dart';
import 'package:movie_libs/helpers/models/movies_list_model.dart';
import 'package:movie_libs/helpers/networking/movie_data_helper.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        Map<String, dynamic> movieDetail = {
          'id' : _movie.id,
          'title' : _movie.title,
        };
        Navigator.pushNamed(context, MovieDetailPage.routeName,
            arguments: movieDetail);
      },
      child: Card(
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
                      maxLines: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (String genre in _genreNames)
                            Container(
                              decoration: BoxDecoration(
                                color: colorScheme.background,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                              ),
                              padding: EdgeInsets.all(4),
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
      ),
    );
  }
}
