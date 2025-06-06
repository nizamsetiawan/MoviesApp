import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_watchlist/tv_series_watchlist_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_series_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<MovieWatchlistBloc>().add(MovieWatchlistGetEvent());
    context.read<TvSeriesWatchlistBloc>().add(TvSeriesWatchlistGetEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<MovieWatchlistBloc>().add(MovieWatchlistGetEvent());
    context.read<TvSeriesWatchlistBloc>().add(TvSeriesWatchlistGetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist', style: TextStyle(fontWeight: FontWeight.normal)),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Movies',
                style: kHeading6.copyWith(color: Colors.deepPurple),
              ),
              SizedBox(height: 8.0),
              BlocBuilder<MovieWatchlistBloc, MovieWatchlistState>(
                builder: (context, state) {
                  if (state is MovieWatchlistLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is MovieWatchlistLoaded) {
                    return state.movies.isEmpty
                        ? Center(child: Text('Your movie watchlist is empty.'))
                        : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.movies.length,
                      itemBuilder: (context, index) {
                        final movie = state.movies[index];
                        return MovieCard(movie);
                      },
                    );
                  }
                  if (state is MovieWatchlistError) {
                    return Center(
                      key: Key('error_message'),
                      child: Text('Failed to load movie watchlist.'),
                    );
                  }
                  return Center(child: Text('No data available.'));
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'TV Series',
                style: kHeading6.copyWith(color: Colors.deepPurple),
              ),
              SizedBox(height: 8.0),
              BlocBuilder<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
                builder: (context, state) {
                  if (state is TvSeriesWatchlistLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is TvSeriesWatchlistLoaded) {
                    return state.tvSeriesList.isEmpty
                        ? Center(child: Text('Your TV series watchlist is empty.'))
                        : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.tvSeriesList.length,
                      itemBuilder: (context, index) {
                        final series = state.tvSeriesList[index];
                        return TvSeriesCard(series);
                      },
                    );
                  }
                  if (state is TvSeriesWatchlistError) {
                    return Center(
                      key: Key('error_message'),
                      child: Text('Failed to load TV series watchlist.'),
                    );
                  }

                  return Center(child: Text('No data available.'));
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
