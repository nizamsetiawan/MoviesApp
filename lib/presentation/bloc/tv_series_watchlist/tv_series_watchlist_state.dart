part of 'tv_series_watchlist_bloc.dart';

abstract class TvSeriesWatchlistState extends Equatable {
  const TvSeriesWatchlistState();

  @override
  List<Object> get props => [];
}

class TvSeriesWatchlistInitial extends TvSeriesWatchlistState {}

class TvSeriesWatchlistLoading extends TvSeriesWatchlistState {}

class TvSeriesWatchlistError extends TvSeriesWatchlistState {
  final String message;
  const TvSeriesWatchlistError({required this.message});

  @override
  List<Object> get props => [message];
}

class TvSeriesWatchlistSuccess extends TvSeriesWatchlistState {
  final String message;
  const TvSeriesWatchlistSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class TvSeriesWatchlistLoaded extends TvSeriesWatchlistState {
  final List<TvSeries> tvSeriesList;
  const TvSeriesWatchlistLoaded({required this.tvSeriesList});

  @override
  List<Object> get props => [tvSeriesList];
}
