import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_top_rated/tv_series_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late TvSeriesTopRatedBloc tvSeriesTopRatedBloc;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    tvSeriesTopRatedBloc = TvSeriesTopRatedBloc(mockGetTopRatedTvSeries);
  });

  final tTvSeries = TvSeries(
    firstAirDate: '321',
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'fdsafds',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    originCountry: ['id'],
    originalLanguage: 'id',
    originalName: 'turkturk,',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('Get Top Rated TV Series', () {
    blocTest<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
      'Should emit [Loading, Loaded] when Get Top Rated TV Series is successful',
      build: () {
        when(mockGetTopRatedTvSeries.execute()).thenAnswer(
              (_) async => Right(tTvSeriesList),
        );
        return tvSeriesTopRatedBloc;
      },
      act: (bloc) => bloc.add(TvSeriesTopRatedGetEvent()),
      expect: () => [
        TvSeriesTopRatedLoading(),
        TvSeriesTopRatedLoaded(tvSeriesList: tTvSeriesList),
      ],
    );

    blocTest<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
      'Should emit [Loading, Error] when Get Top Rated TV Series fails',
      build: () {
        when(mockGetTopRatedTvSeries.execute()).thenAnswer(
              (_) async => Left(ServerFailure('Server Failure')),
        );
        return tvSeriesTopRatedBloc;
      },
      act: (bloc) => bloc.add(TvSeriesTopRatedGetEvent()),
      expect: () => [
        TvSeriesTopRatedLoading(),
        TvSeriesTopRatedError(message: 'Server Failure'),
      ],
    );
  });
}
