import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import '../../../domain/entities/movie.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetWatchlistMovies getWatchlistMovies;
  final RemoveWatchlist removeWatchlist;
  final SaveWatchlist saveWatchlist;

  MovieWatchlistBloc(
      this.getWatchlistMovies,
      this.removeWatchlist,
      this.saveWatchlist,
      ) : super(const MovieWatchlistInitial()) {
    on<MovieWatchlistGetEvent>(_onGetWatchlistMovies);
    on<MovieWatchlistAddEvent>(_onAddToWatchlist);
    on<MovieWatchlistRemoveEvent>(_onRemoveFromWatchlist);
  }

  Future<void> _onGetWatchlistMovies(
      MovieWatchlistGetEvent event,
      Emitter<MovieWatchlistState> emit,
      ) async {
    emit(const MovieWatchlistLoading());
    final result = await getWatchlistMovies.execute();
    result.fold(
          (failure) => emit(MovieWatchlistError(message: failure.message)),
          (movies) => emit(MovieWatchlistLoaded(movies: movies)),
    );
  }

  Future<void> _onAddToWatchlist(
      MovieWatchlistAddEvent event,
      Emitter<MovieWatchlistState> emit,
      ) async {
    emit(const MovieWatchlistLoading());
    final result = await saveWatchlist.execute(event.movieDetail);
    result.fold(
          (failure) => emit(MovieWatchlistError(message: failure.message)),
          (message) => emit(MovieWatchlistAddSuccess(message: message)),
    );
  }

  Future<void> _onRemoveFromWatchlist(
      MovieWatchlistRemoveEvent event,
      Emitter<MovieWatchlistState> emit,
      ) async {
    emit(const MovieWatchlistLoading());
    final result = await removeWatchlist.execute(event.movieDetail);
    result.fold(
          (failure) => emit(MovieWatchlistError(message: failure.message)),
          (message) => emit(MovieWatchlistAddSuccess(message: message)),
    );
  }
}
