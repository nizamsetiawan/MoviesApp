import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ditonton/domain/usecases/search_movies.dart';
import '../../../domain/entities/movie.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies usecases;

  MovieSearchBloc(this.usecases) : super(const MovieSearchInitial()) {
    on<MovieSearchQueryEvent>(_onSearchMovies);
  }

  Future<void> _onSearchMovies(
      MovieSearchQueryEvent event,
      Emitter<MovieSearchState> emit,
      ) async {
    emit(const MovieSearchLoading());

    final result = await usecases.execute(event.query);
    result.fold(
          (failure) => emit(MovieSearchError(message: failure.message)),
          (movies) => emit(MovieSearchLoaded(movies: movies)),
    );
  }
}
