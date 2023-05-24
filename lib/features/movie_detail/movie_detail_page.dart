import 'package:flutter/material.dart';
import 'package:movie_libs/features/movie_detail/view_components/movie_detail_info_card.dart';
import 'package:movie_libs/features/movie_detail/view_components/movie_info_text.dart';
import 'package:movie_libs/features/movie_detail/view_components/movie_trailer_card.dart';
import 'package:movie_libs/features/movie_detail/view_components/production_companies_card.dart';

class MovieDetailPage extends StatefulWidget {
  static String routeName = '/movie_detail';

  int movieId;
  String title;

  MovieDetailPage({super.key, required this.movieId, required this.title});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  double _scrollColorLerp = 0.0;
  final List<String> _tabs = [
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
        title: Text(widget.title),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Theme.of(context).colorScheme.onPrimaryContainer,
          tabs: _tabs.map((e) => Tab(text: e)).toList(),
          onTap: (value) => print(value),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((e) => tabSelectionView(context, e)).toList(),
      ),
    );
  }

  Widget tabSelectionView(BuildContext context, String title) {
    final appTheme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    if (title == _tabs[0]) {
      // Overview
      return SingleChildScrollView(
        child: SafeArea(
          top: false,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image of poster
                Image.network(
                    'https://s1.bukalapak.com/img/68286857232/large/Poster_Film___Avengers_Endgame___Marvel_Studios___Movie_Post.jpg'),
                MovieDetailInfoCard(
                  title: 'Synopsis',
                  content: Container(
                    width: double.infinity,
                    child: Text('The synopsis text'),
                  ),
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
                        childAspectRatio: 4.2,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: appTheme.colorScheme.background,
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(child: Text('abc')),
                        );
                      },
                    ),
                  ),
                ),
                MovieDetailInfoCard(
                  title: 'Information',
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MovieInfoText(
                        useFlex: false,
                        title: 'Revenue',
                        content: Text(
                          '\$336,351,055.00',
                          style: appTheme.textTheme.headlineMedium,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MovieInfoText(
                              useFlex: false,
                              title: 'Release Date',
                              content: Column(
                                children: [
                                  Text(
                                    'Jan 7'.toUpperCase(),
                                    style: appTheme.textTheme.labelSmall,
                                  ),
                                  Text(
                                    '2022',
                                    style: appTheme.textTheme.titleLarge,
                                  ),
                                ],
                              ),
                            ),
                            MovieInfoText(
                              useFlex: false,
                              title: 'Runtime',
                              content: Text(
                                '1h 43min',
                                style: appTheme.textTheme.headlineMedium,
                              ),
                            ),
                            MovieInfoText(
                              useFlex: false,
                              title: 'User Score',
                              content: Text(
                                '86%',
                                style: appTheme.textTheme.headlineLarge,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                MovieDetailInfoCard(
                  title: 'Production Companies',
                  content: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 3,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          3, // If prod company count >= 3 then 3, otherwise genre count
                      childAspectRatio: 1.0,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                    ),
                    itemBuilder: (context, index) {
                      return const ProductionCompanyCard(
                        imageUrl: 'https://picsum.photos/250?image=9',
                        name: 'Name',
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (title == _tabs[1]) {
      // Trailer
      return ListView.builder(
        padding: mediaQuery.padding.copyWith(top: 5.0),
        itemCount: 20, // Trailer counts, get data from API
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0,
            ),
            child: const MovieTrailerCard(
              youtubeID: 'GQyWIur03aw',
            ),
          );
        },
      );
    } else if (title == _tabs[2]) {
      // Reviews
      return ListView.builder(
        padding: mediaQuery.padding.copyWith(top: 5.0),
        itemCount: 20, // Review count, get data from API
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0,
            ),
            child: MovieReviewCard(),
          );
        },
      );
    } else {
      return Center(child: Text('Index not found'));
    }
  }
}

class MovieReviewCard extends StatelessWidget {
  const MovieReviewCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name'),
                      Text('username'),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text('Review text'),
            ),
            Text('date'),
          ],
        ),
      ),
    );
  }
}
