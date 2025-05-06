part of 'movie_top_rated_bloc.dart';

abstract class MovieTopRatedState extends Equatable {
  const MovieTopRatedState();

  @override
  List<Object> get props => [];
}

class MovieTopRatedInitial extends MovieTopRatedState {
  const MovieTopRatedInitial();
}

class MovieTopRatedLoading extends MovieTopRatedState {
  const MovieTopRatedLoading();
}

class MovieTopRatedError extends MovieTopRatedState {
  final String message;

  const MovieTopRatedError({required this.message});

  @override
  List<Object> get props => [message];
}

class MovieTopRatedLoaded extends MovieTopRatedState {
  final List<Movie> movies;

  const MovieTopRatedLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}
