import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';

part 'movie_now_playing_event.dart';
part 'movie_now_playing_state.dart';

class MovieNowPlayingBloc
    extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final GetNowPlayingMovies usecases;

  MovieNowPlayingBloc(this.usecases) : super(const MovieNowPlayingInitial()) {
    on<MovieNowPlayingGetEvent>(_onGetNowPlayingMovies);
  }

  Future<void> _onGetNowPlayingMovies(
      MovieNowPlayingGetEvent event,
      Emitter<MovieNowPlayingState> emit,
      ) async {
    emit(const MovieNowPlayingLoading());

    final result = await usecases.execute();
    result.fold(
          (failure) => emit(MovieNowPlayingError(message: failure.message)),
          (movies) => emit(MovieNowPlayingLoaded(movies: movies)),
    );
  }
}
