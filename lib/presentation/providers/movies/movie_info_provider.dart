import 'package:cinemapedia/domain/entities/movies.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repositories_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieInfoProvider = StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final getMovie = ref.watch(moviesRepositoryProvider).getMovieById;
  return MovieMapNotifier(
    getMovie: getMovie,
  );
});


typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {

  final GetMovieCallback getMovie;

  MovieMapNotifier({ required this.getMovie }) : super({});

  Future<void> loadMovie( movieId ) async {
    if ( state[movieId] != null ) return;

    final movie = await getMovie( movieId );

    state = { ...state, movieId: movie };
  }

}