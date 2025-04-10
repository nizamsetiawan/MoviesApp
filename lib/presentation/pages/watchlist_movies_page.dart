import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_series_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_series_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/constants.dart';

class CombinedWatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  @override
  _CombinedWatchlistPageState createState() => _CombinedWatchlistPageState();
}

class _CombinedWatchlistPageState extends State<CombinedWatchlistPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<WatchlistMovieNotifier>(context, listen: false)
          .fetchWatchlistMovies();
      Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
          .fetchWatchlistTvSeries();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
        .fetchWatchlistTvSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Movies Section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Movies',
                  style: kHeading6,
                ),
              ),
              Consumer<WatchlistMovieNotifier>(
                builder: (context, movieData, child) {
                  if (movieData.watchlistState == RequestState.Loading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (movieData.watchlistState == RequestState.Loaded) {
                    return movieData.watchlistMovies.isNotEmpty
                        ? ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: movieData.watchlistMovies.length,
                      itemBuilder: (context, index) {
                        final movie = movieData.watchlistMovies[index];
                        return MovieCard(movie);
                      },
                    )
                        : Center(child: Text('No movies in watchlist'));
                  } else {
                    return Center(child: Text(movieData.message));
                  }
                },
              ),

              SizedBox(height: 16),

              // TV Series Section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'TV Series',
                  style: kHeading6,
                ),
              ),
              Consumer<WatchlistTvSeriesNotifier>(
                builder: (context, tvData, child) {
                  if (tvData.watchlistState == RequestState.Loading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (tvData.watchlistState == RequestState.Loaded) {
                    return tvData.watchlistTvSeries.isNotEmpty
                        ? ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: tvData.watchlistTvSeries.length,
                      itemBuilder: (context, index) {
                        final tvSeries = tvData.watchlistTvSeries[index];
                        return TvSeriesCard(tvSeries);
                      },
                    )
                        : Center(child: Text('No TV series in watchlist'));
                  } else {
                    return Center(child: Text(tvData.message));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}