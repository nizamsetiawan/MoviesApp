import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:equatable/equatable.dart';

import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchlistMovies;

  MovieDetailBloc(
      this.getMovieDetail,
      this.getMovieRecommendations,
      this.getWatchlistMovies,
      ) : super(MovieDetailInitial()) {
    on<MovieDetailGetEvent>(_onGetMovieDetail);
  }

  Future<void> _onGetMovieDetail(
      MovieDetailGetEvent event,
      Emitter<MovieDetailState> emit,
      ) async {
    emit(MovieDetailLoading());

    final detailResult = await getMovieDetail.execute(event.id);
    final recommendationResult = await getMovieRecommendations.execute(event.id);
    final isWatchlist = await getWatchlistMovies.execute(event.id);

    detailResult.fold(
          (failure) {
        emit(MovieDetailError(message: failure.message));
      },
          (detail) {
        recommendationResult.fold(
              (failure) {
            emit(MovieDetailError(message: failure.message));
          },
              (recommendations) {
            emit(MovieDetailLoaded(
              detail: detail,
              recommendations: recommendations,
              isWatchlist: isWatchlist,
            ));
          },
        );
      },
    );
  }
}
