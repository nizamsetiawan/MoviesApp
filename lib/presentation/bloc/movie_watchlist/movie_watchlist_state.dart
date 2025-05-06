part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object> get props => [];
}

class MovieWatchlistInitial extends MovieWatchlistState {
  const MovieWatchlistInitial();
}

class MovieWatchlistLoading extends MovieWatchlistState {
  const MovieWatchlistLoading();
}

class MovieWatchlistError extends MovieWatchlistState {
  final String message;

  const MovieWatchlistError({required this.message});

  @override
  List<Object> get props => [message];
}

class MovieWatchlistAddSuccess extends MovieWatchlistState {
  final String message;

  const MovieWatchlistAddSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class MovieWatchlistLoaded extends MovieWatchlistState {
  final List<Movie> movies;

  const MovieWatchlistLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}
