import 'package:flutter/material.dart';

class MovieDetailPage extends StatefulWidget {
  static String routeName = '/movie_detail';

  const MovieDetailPage({super.key});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  double _scrollColorLerp = 0.0;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: 200,
              iconTheme: IconThemeData(
                  color: Color.lerp(appTheme.colorScheme.onSurfaceVariant,
                      Colors.white, _scrollColorLerp)),
              // title: Text('App bar is here'),
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  double titleBarConstraint = constraints.biggest.height;
                  double safeAreaTop = MediaQuery.of(context).padding.top;
                  // Pakai angka ini untuk bahan pertimbangan warna text
                  print(
                      'Title Bar Height: ${titleBarConstraint - safeAreaTop}');
                  // 56 - 110 (title bar value)
                  // 0 - 1 (lerp value)
                  double titleBarHeight = titleBarConstraint - safeAreaTop;

                  if (titleBarHeight <= 110) {
                    _scrollColorLerp = (titleBarHeight - 56) / (110 - 56);
                  } else {
                    _scrollColorLerp = 1;
                  }
                  return FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      'Movie title goes here',
                      style: TextStyle(
                          color: Color.lerp(appTheme.colorScheme.inverseSurface,
                              Colors.white, _scrollColorLerp)),
                    ),
                    background: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png',
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ];
        },
        body: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) => Text("Item $index"),
        ),
      ),
    );
  }
}
