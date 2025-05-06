part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {
  const MovieDetailInitial();
}

class MovieDetailLoading extends MovieDetailState {
  const MovieDetailLoading();
}

class MovieDetailError extends MovieDetailState {
  final String message;

  const MovieDetailError({required this.message});

  @override
  List<Object> get props => [message];
}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail detail;
  final List<Movie> recommendations;
  final bool isWatchlist;

  const MovieDetailLoaded({
    required this.detail,
    required this.recommendations,
    required this.isWatchlist,
  });

  @override
  List<Object> get props => [detail, recommendations, isWatchlist];
}
