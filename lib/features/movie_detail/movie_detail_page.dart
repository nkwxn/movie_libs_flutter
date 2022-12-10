import 'package:flutter/material.dart';

class MovieDetailPage extends StatefulWidget {
  static String routeName = '/movie_detail';

  const MovieDetailPage({super.key});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            stretch: true,
            expandedHeight: 200,
            // title: Text('App bar is here'),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'Movie title goes here',
                style: TextStyle(color: appTheme.colorScheme.inverseSurface),
              ),
              background: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
