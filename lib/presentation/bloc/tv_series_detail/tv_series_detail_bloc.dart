import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tv_series_watchlist_status.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;
  final GetTvSeriesWatchListStatus getTvSeriesWatchListStatus;

  TvSeriesDetailBloc(
      this.getTvSeriesDetail,
      this.getTvSeriesRecommendations,
      this.getTvSeriesWatchListStatus,
      ) : super(TvSeriesDetailInitial()) {
    on<TvSeriesDetailGetEvent>(_onGetTvSeriesDetail);
  }

  Future<void> _onGetTvSeriesDetail(
      TvSeriesDetailGetEvent event,
      Emitter<TvSeriesDetailState> emit,
      ) async {
    emit(TvSeriesDetailLoading());

    final detailResult = await getTvSeriesDetail.execute(event.id);
    final recommendationResult = await getTvSeriesRecommendations.execute(event.id);
    final isWatchlist = await getTvSeriesWatchListStatus.execute(event.id);

    detailResult.fold(
          (failure) => emit(TvSeriesDetailError(failure.message)),
          (detail) async {
        recommendationResult.fold(
              (failure) => emit(TvSeriesDetailError(failure.message)),
              (recommendations) {
            emit(TvSeriesDetailLoaded(
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
