import 'package:cinemapedia/domain/entities/movies.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'movies_providers.dart';

final moviesSlideShowProvider = Provider<List<Movie>>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

  if(nowPlayingMovies.isEmpty) return [];

  return nowPlayingMovies.getRange(0, 6).toList();
});