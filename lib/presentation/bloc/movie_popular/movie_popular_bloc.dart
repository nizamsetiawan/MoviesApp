import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import '../../../domain/entities/movie.dart';

part 'movie_popular_event.dart';
part 'movie_popular_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final GetPopularMovies usecases;

  MoviePopularBloc(this.usecases) : super(const MoviePopularInitial()) {
    on<MoviePopularGetEvent>(_onGetPopularMovies);
  }

  Future<void> _onGetPopularMovies(
      MoviePopularGetEvent event,
      Emitter<MoviePopularState> emit,
      ) async {
    emit(const MoviePopularLoading());

    final result = await usecases.execute();
    result.fold(
          (failure) => emit(MoviePopularError(message: failure.message)),
          (movies) => emit(MoviePopularLoaded(movies: movies)),
    );
  }
}
