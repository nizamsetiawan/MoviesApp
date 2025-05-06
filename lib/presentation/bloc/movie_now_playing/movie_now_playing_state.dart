part of 'movie_now_playing_bloc.dart';

abstract class MovieNowPlayingState extends Equatable {
  const MovieNowPlayingState();

  @override
  List<Object> get props => [];
}

class MovieNowPlayingInitial extends MovieNowPlayingState {
  const MovieNowPlayingInitial();
}

class MovieNowPlayingLoading extends MovieNowPlayingState {
  const MovieNowPlayingLoading();
}

class MovieNowPlayingError extends MovieNowPlayingState {
  final String message;

  const MovieNowPlayingError({required this.message});

  @override
  List<Object> get props => [message];
}

class MovieNowPlayingLoaded extends MovieNowPlayingState {
  final List<Movie> movies;

  const MovieNowPlayingLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}
