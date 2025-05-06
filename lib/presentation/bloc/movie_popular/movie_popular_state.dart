part of 'movie_popular_bloc.dart';

abstract class MoviePopularState extends Equatable {
  const MoviePopularState();

  @override
  List<Object> get props => [];
}

class MoviePopularInitial extends MoviePopularState {
  const MoviePopularInitial();
}

class MoviePopularLoading extends MoviePopularState {
  const MoviePopularLoading();
}

class MoviePopularError extends MoviePopularState {
  final String message;

  const MoviePopularError({required this.message});

  @override
  List<Object> get props => [message];
}

class MoviePopularLoaded extends MoviePopularState {
  final List<Movie> movies;

  const MoviePopularLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}
