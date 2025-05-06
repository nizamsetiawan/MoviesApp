import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';

part 'tv_series_popular_event.dart';
part 'tv_series_popular_state.dart';

class TvSeriesPopularBloc
    extends Bloc<TvSeriesPopularEvent, TvSeriesPopularState> {
  final GetPopularTvSeries usecases;

  TvSeriesPopularBloc(this.usecases) : super(TvSeriesPopularInitial()) {
    on<TvSeriesPopularGetEvent>(_onGetPopularTvSeries);
  }

  Future<void> _onGetPopularTvSeries(
      TvSeriesPopularGetEvent event,
      Emitter<TvSeriesPopularState> emit,
      ) async {
    emit(TvSeriesPopularLoading());

    final result = await usecases.execute();
    result.fold(
          (failure) => emit(TvSeriesPopularError(message: failure.message)),
          (tvSeriesList) => emit(TvSeriesPopularLoaded(tvSeriesList: tvSeriesList)),
    );
  }
}
