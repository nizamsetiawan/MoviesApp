import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_airing_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_airing/tv_series_airing_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_airing_bloc_test.mocks.dart';

@GenerateMocks([GetAiringTvSeries])
void main() {
  late MockGetAiringTvSeries mockGetAiringTvSeries;
  late TvSeriesAiringBloc tvSeriesAiringBloc;

  setUp(() {
    mockGetAiringTvSeries = MockGetAiringTvSeries();
    tvSeriesAiringBloc = TvSeriesAiringBloc(mockGetAiringTvSeries);
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

  group('Get Airing TV Series', () {
    blocTest<TvSeriesAiringBloc, TvSeriesAiringState>(
      'Should emit [Loading, Loaded] when Get Airing TV Series is successful',
      build: () {
        when(mockGetAiringTvSeries.execute()).thenAnswer(
              (_) async => Right(tTvSeriesList),
        );
        return tvSeriesAiringBloc;
      },
      act: (bloc) => bloc.add(TvSeriesAiringGetEvent()),
      expect: () => [
        TvSeriesAiringLoading(),
        TvSeriesAiringLoaded(tvSeriesList: tTvSeriesList),
      ],
    );

    blocTest<TvSeriesAiringBloc, TvSeriesAiringState>(
      'Should emit [Loading, Error] when Get Airing TV Series fails',
      build: () {
        when(mockGetAiringTvSeries.execute()).thenAnswer(
              (_) async => Left(ServerFailure('Server Failure')),
        );
        return tvSeriesAiringBloc;
      },
      act: (bloc) => bloc.add(TvSeriesAiringGetEvent()),
      expect: () => [
        TvSeriesAiringLoading(),
        TvSeriesAiringError(message: 'Server Failure'),
      ],
    );
  });
}
