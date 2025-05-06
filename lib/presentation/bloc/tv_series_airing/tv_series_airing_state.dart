part of 'tv_series_airing_bloc.dart';

abstract class TvSeriesAiringState extends Equatable {
  const TvSeriesAiringState();

  @override
  List<Object> get props => [];
}

class TvSeriesAiringInitial extends TvSeriesAiringState {
  const TvSeriesAiringInitial();
}

class TvSeriesAiringLoading extends TvSeriesAiringState {
  const TvSeriesAiringLoading();
}

class TvSeriesAiringError extends TvSeriesAiringState {
  final String message;

  const TvSeriesAiringError({required this.message});

  @override
  List<Object> get props => [message];
}

class TvSeriesAiringLoaded extends TvSeriesAiringState {
  final List<TvSeries> tvSeriesList;

  const TvSeriesAiringLoaded({required this.tvSeriesList});

  @override
  List<Object> get props => [tvSeriesList];
}
