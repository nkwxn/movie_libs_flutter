import 'package:flutter/material.dart';
import 'dart:math' as math;

class MovieDetailPage extends StatefulWidget {
  static String routeName = '/movie_detail';

  int movieId;

  MovieDetailPage({super.key, required this.movieId});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  double _scrollColorLerp = 0.0;
  List<String> _tabs = [
    'Overview',
    'Trailers',
    'Reviews',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  void getMovieDetails() async {}

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie ID: ${widget.movieId}'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Theme.of(context).colorScheme.onPrimaryContainer,
          tabs: _tabs.map((e) => Tab(text: e)).toList(),
          onTap: (value) => print(value),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((e) => tabSelectionView(e)).toList(),
      ),
    );
  }

  Widget tabSelectionView(String title) {
    if (title == _tabs[0]) {
      return SingleChildScrollView(
        child: SafeArea(
          top: false,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image.network('https://s1.bukalapak.com/img/68286857232/large/Poster_Film___Avengers_Endgame___Marvel_Studios___Movie_Post.jpg'),
                MovieDetailInfoCard(
                  title: 'Synopsis',
                  content: Text('The synopsis text'),
                ),
                MovieDetailInfoCard(
                  title: 'Genres',
                  content: Container(
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 3,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            3, // If genre count >= 3 then 3, otherwise genre count
                        childAspectRatio: 4.0,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                      ),
                      itemBuilder: (context, index) {
                        // ColorScheme color =
                        return Container(
                          color: Colors.blue,
                          child: Center(child: Text('abc')),
                        );
                      },
                    ),
                  ),
                ),
                MovieDetailInfoCard(
                  title: 'Information',
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Revenue'),
                      Text('\$336,351,055.00'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('Release Date'),
                              Text('Jan 7'),
                              Text('2022'),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Runtime'),
                              Text('1h 43min'),
                            ],
                          ),
                          Column(
                            children: [
                              Text('User Score'),
                              Text('86%'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                MovieDetailInfoCard(
                  title: 'Production Companies',
                  content: Text('Production Companies grid list'),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (title == _tabs[1]) {
      return SafeArea(
        top: false,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: Text('Co'),
        ),
      );
    } else if (title == _tabs[2]) {
      return SafeArea(
        top: false,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: Text('eek'),
        ),
      );
    } else {
      return Center(child: Text('Index not found'));
    }
  }
}

class MovieDetailInfoCard extends StatelessWidget {
  final String title;
  final Widget content;
  MovieDetailInfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                content,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
