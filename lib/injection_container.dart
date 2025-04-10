import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/domain/usecases/get_airing_tv_series.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:ditonton/presentation/provider/airing_tv_series_notifier.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/popular_tv_series_notifier.dart';
import 'package:ditonton/presentation/provider/search_tv_series_notifier.dart';
import 'package:ditonton/presentation/provider/top_rate_tv_series_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_series_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'data/datasources/tv_series_local_data_source.dart';
import 'domain/usecases/get_tv_series_watchlist_status.dart';
import 'domain/usecases/get_watchlist_tv_series.dart';
import 'domain/usecases/remove_tv_series_watchlist.dart';
import 'domain/usecases/save_tv_series_watchlist.dart';

final sl = GetIt.instance;

void init() {
  // provider
  sl.registerFactory(
        () => MovieListNotifier(
      getNowPlayingMovies: sl(),
      getPopularMovies: sl(),
      getTopRatedMovies: sl(),
    ),
  );
  sl.registerFactory(
        () => MovieDetailNotifier(
      getMovieDetail: sl(),
      getMovieRecommendations: sl(),
      getWatchListStatus: sl(),
      saveWatchlist: sl(),
      removeWatchlist: sl(),
    ),
  );
  sl.registerFactory(
        () => MovieSearchNotifier(
      searchMovies: sl(),
    ),
  );
  sl.registerFactory(
        () => PopularMoviesNotifier(
      sl(),
    ),
  );
  sl.registerFactory(
        () => TopRatedMoviesNotifier(
      getTopRatedMovies: sl(),
    ),
  );
  sl.registerFactory(
        () => WatchlistMovieNotifier(
      getWatchlistMovies: sl(),
    ),
  );

  sl.registerFactory(
        () => PopularTvSeriesNotifier(
      getPopularTvSeries: sl(),
    ),
  );
  sl.registerFactory(
        () => TvSeriesDetailNotifier(
      getTvSeriesDetail: sl(),
      getTvSeriesRecommendations: sl(),
      getTvSeriesWatchListStatus: sl(),
      saveTvSeriesWatchlist: sl(),
      removeTvSeriesWatchlist: sl(),
    ),
  );

  sl.registerFactory(
        () => AiringTvSeriesNotifier(
      getAiringTvSeries: sl(),
    ),
  );

  sl.registerFactory(
        () => TopRatedTvSeriesNotifier(
      getTopRatedTvSeries: sl(),
    ),
  );

  sl.registerFactory(
        () => SearchTvSeriesNotifier(
      searchTvSeries: sl(),
    ),
  );

  sl.registerFactory(
        () => WatchlistTvSeriesNotifier(
      getWatchlistTvSeries: sl(),
    ),
  );

  // use case
  sl.registerLazySingleton(() => GetNowPlayingMovies(sl()));
  sl.registerLazySingleton(() => GetPopularMovies(sl()));
  sl.registerLazySingleton(() => GetTopRatedMovies(sl()));
  sl.registerLazySingleton(() => GetMovieDetail(sl()));
  sl.registerLazySingleton(() => GetMovieRecommendations(sl()));
  sl.registerLazySingleton(() => SearchMovies(sl()));
  sl.registerLazySingleton(() => GetWatchListStatus(sl()));
  sl.registerLazySingleton(() => SaveWatchlist(sl()));
  sl.registerLazySingleton(() => RemoveWatchlist(sl()));
  sl.registerLazySingleton(() => GetWatchlistMovies(sl()));
  sl.registerLazySingleton(
        () => GetPopularTvSeries(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
        () => GetTvSeriesDetail(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
        () => GetTvSeriesRecommendations(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
        () => GetAiringTvSeries(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
        () => GetTopRatedTvSeries(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
        () => SearchTvSeries(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
        () => GetTvSeriesWatchListStatus(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
        () => SaveTvSeriesWatchlist(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
        () => RemoveTvSeriesWatchlist(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
        () => GetWatchlistTvSeries(
      repository: sl(),
    ),
  );

  // repository
  sl.registerLazySingleton<MovieRepository>(
        () => MovieRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<TvSeriesRepository>(
        () => TvSeriesRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // data sources
  sl.registerLazySingleton<MovieRemoteDataSource>(
          () => MovieRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<TvSeriesRemoteDataSource>(
          () => TvSeriesRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<MovieLocalDataSource>(
          () => MovieLocalDataSourceImpl(databaseHelper: sl()));
  sl.registerLazySingleton<TvSeriesLocalDataSource>(
          () => TvSeriesLocalDataSourceImpl(databaseHelper: sl()));

  // helper
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  sl.registerLazySingleton(() => http.Client());
}