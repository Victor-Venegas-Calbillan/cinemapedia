import 'package:cinema_app/domain/entities/movie.dart';
import 'package:cinema_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryprovider = StateProvider<String>((ref) => '');


final searchedMoviesProvider = StateNotifierProvider<SearchMoviesNotifier, List<Movie>>((ref) {
  final moviesRepository = ref.read(movieRepositoryProvider);
  return SearchMoviesNotifier(
    searchMovies: moviesRepository.searchMovies, 
    ref: ref
  );
});

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMoviesNotifier extends StateNotifier<List<Movie>> {

  final SearchMoviesCallback searchMovies;
  final Ref ref;

  SearchMoviesNotifier({
    required this.searchMovies,
    required this.ref,
  }) : super([]);

  Future<List<Movie>> searchMoviesByQuery( String query) async {

    final List<Movie> movies = await searchMovies(query);

    ref.read(searchQueryprovider.notifier).update((state) => query);

    state = movies;

    return movies;
  }
}