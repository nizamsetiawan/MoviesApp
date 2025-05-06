import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_series_watchlist.dart';

part 'tv_series_watchlist_event.dart';
part 'tv_series_watchlist_state.dart';

class TvSeriesWatchlistBloc
    extends Bloc<TvSeriesWatchlistEvent, TvSeriesWatchlistState> {
  final GetWatchlistTvSeries getWatchlistTvSeries;
  final RemoveTvSeriesWatchlist removeTvSeriesWatchlist;
  final SaveTvSeriesWatchlist saveTvSeriesWatchlist;

  TvSeriesWatchlistBloc(
      this.getWatchlistTvSeries,
      this.removeTvSeriesWatchlist,
      this.saveTvSeriesWatchlist,
      ) : super(TvSeriesWatchlistInitial()) {
    on<TvSeriesWatchlistGetEvent>(_onGetWatchlist);
    on<TvSeriesWatchlistAddEvent>(_onAddToWatchlist);
    on<TvSeriesWatchlistRemoveEvent>(_onRemoveFromWatchlist);
  }

  Future<void> _onGetWatchlist(
      TvSeriesWatchlistGetEvent event,
      Emitter<TvSeriesWatchlistState> emit,
      ) async {
    emit(TvSeriesWatchlistLoading());
    final result = await getWatchlistTvSeries.execute();
    result.fold(
          (failure) => emit(TvSeriesWatchlistError(message: failure.message)),
          (tvSeriesList) => emit(TvSeriesWatchlistLoaded(tvSeriesList: tvSeriesList)),
    );
  }

  Future<void> _onAddToWatchlist(
      TvSeriesWatchlistAddEvent event,
      Emitter<TvSeriesWatchlistState> emit,
      ) async {
    emit(TvSeriesWatchlistLoading());
    final result = await saveTvSeriesWatchlist.execute(event.detail);
    result.fold(
          (failure) => emit(TvSeriesWatchlistError(message: failure.message)),
          (message) => emit(TvSeriesWatchlistSuccess(message: message)),
    );
  }

  Future<void> _onRemoveFromWatchlist(
      TvSeriesWatchlistRemoveEvent event,
      Emitter<TvSeriesWatchlistState> emit,
      ) async {
    emit(TvSeriesWatchlistLoading());
    final result = await removeTvSeriesWatchlist.execute(event.detail);
    result.fold(
          (failure) => emit(TvSeriesWatchlistError(message: failure.message)),
          (message) => emit(TvSeriesWatchlistSuccess(message: message)),
    );
  }
}
