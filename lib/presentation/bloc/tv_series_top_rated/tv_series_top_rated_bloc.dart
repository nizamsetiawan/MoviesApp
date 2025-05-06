import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';

part 'tv_series_top_rated_event.dart';
part 'tv_series_top_rated_state.dart';

class TvSeriesTopRatedBloc
    extends Bloc<TvSeriesTopRatedEvent, TvSeriesTopRatedState> {
  final GetTopRatedTvSeries usecases;

  TvSeriesTopRatedBloc(this.usecases) : super(TvSeriesTopRatedInitial()) {
    on<TvSeriesTopRatedGetEvent>(_onGetTopRatedTvSeries);
  }

  Future<void> _onGetTopRatedTvSeries(
      TvSeriesTopRatedGetEvent event,
      Emitter<TvSeriesTopRatedState> emit,
      ) async {
    emit(TvSeriesTopRatedLoading());

    final result = await usecases.execute();
    result.fold(
          (failure) => emit(TvSeriesTopRatedError(message: failure.message)),
          (tvSeriesList) => emit(TvSeriesTopRatedLoaded(tvSeriesList: tvSeriesList)),
    );
  }
}
