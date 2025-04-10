import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/airing_tv_series_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_series_page.dart';
import 'package:ditonton/presentation/provider/airing_tv_series_notifier.dart';
import 'package:ditonton/presentation/provider/popular_tv_series_notifier.dart';
import 'package:ditonton/presentation/provider/top_rate_tv_series_notifier.dart';
import 'package:ditonton/presentation/widgets/sub_heading.dart';
import 'package:ditonton/presentation/widgets/tv_series_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'about_page.dart';
import 'home_movie_page.dart';
import 'search_page.dart';
import 'watchlist_movies_page.dart';

class TvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/series';
  const TvSeriesPage({Key? key}) : super(key: key);

  @override
  State<TvSeriesPage> createState() => _TvSeriesPageState();
}

class _TvSeriesPageState extends State<TvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<PopularTvSeriesNotifier>(context, listen: false)
        ..fetchPopularTvSeries();
      Provider.of<AiringTvSeriesNotifier>(context, listen: false)
        ..fetchAiringTvSeries();
      Provider.of<TopRatedTvSeriesNotifier>(context, listen: false)
        ..fetchTopRatedTvSeries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Nizam Setiawan'),
              accountEmail: Text('nizamsetiawan15@gmail.com'),
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('TV Series'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, CombinedWatchlistPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                SearchPage.ROUTE_NAME,
                arguments: false,
              );
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubHeading(
                title: 'Now Playing',
                onTap: () =>
                    Navigator.pushNamed(context, AiringTvSeriesPage.ROUTE_NAME),
              ),
              Consumer<AiringTvSeriesNotifier>(
                builder: (context, data, child) {
                  final state = data.state;
                  if (state == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == RequestState.Loaded) {
                    return TvSeriesList(data.series);
                  } else {
                    return Text('Failed');
                  }
                },
              ),
              SubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(
                    context, PopularTvSeriesPage.ROUTE_NAME),
              ),
              // tv series popular
              Consumer<PopularTvSeriesNotifier>(
                builder: (context, data, child) {
                  final state = data.state;
                  if (state == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == RequestState.Loaded) {
                    return TvSeriesList(data.series);
                  } else {
                    return Text('Failed');
                  }
                },
              ),
              SubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(
                    context, TopRatedTvSeriesPage.ROUTE_NAME),
              ),
              //tv series top rated
              Consumer<TopRatedTvSeriesNotifier>(
                builder: (context, data, child) {
                  final state = data.state;
                  if (state == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == RequestState.Loaded) {
                    return TvSeriesList(data.series);
                  } else {
                    return Text('Failed');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}