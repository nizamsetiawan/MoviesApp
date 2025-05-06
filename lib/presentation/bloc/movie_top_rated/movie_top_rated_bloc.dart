import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import '../../../domain/entities/movie.dart';

part 'movie_top_rated_event.dart';
part 'movie_top_rated_state.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  final GetTopRatedMovies usecases;

  MovieTopRatedBloc(this.usecases) : super(const MovieTopRatedInitial()) {
    on<MovieTopRatedGetEvent>(_onGetTopRatedMovies);
  }

  Future<void> _onGetTopRatedMovies(
      MovieTopRatedGetEvent event,
      Emitter<MovieTopRatedState> emit,
      ) async {
    emit(const MovieTopRatedLoading());

    final result = await usecases.execute();
    result.fold(
          (failure) => emit(MovieTopRatedError(message: failure.message)),
          (movies) => emit(MovieTopRatedLoaded(movies: movies)),
    );
  }
}
