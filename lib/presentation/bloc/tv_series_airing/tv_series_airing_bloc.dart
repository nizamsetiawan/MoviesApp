import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_airing_tv_series.dart';

part 'tv_series_airing_event.dart';
part 'tv_series_airing_state.dart';

class TvSeriesAiringBloc
    extends Bloc<TvSeriesAiringEvent, TvSeriesAiringState> {
  final GetAiringTvSeries usecases;

  TvSeriesAiringBloc(this.usecases) : super(const TvSeriesAiringInitial()) {
    on<TvSeriesAiringGetEvent>(_onGetAiringTvSeries);
  }

  Future<void> _onGetAiringTvSeries(
      TvSeriesAiringGetEvent event,
      Emitter<TvSeriesAiringState> emit,
      ) async {
    emit(const TvSeriesAiringLoading());
    final result = await usecases.execute();
    result.fold(
          (failure) => emit(TvSeriesAiringError(message: failure.message)),
          (tvSeriesList) => emit(TvSeriesAiringLoaded(tvSeriesList: tvSeriesList)),
    );
  }
}
