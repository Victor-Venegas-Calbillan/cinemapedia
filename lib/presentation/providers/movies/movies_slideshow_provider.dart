
import 'package:cinema_app/domain/entities/movie.dart';
import 'package:cinema_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieSlideshowPorvider = Provider<List<Movie>>((ref) {
  final movies = ref.watch(nowPlayingMoviesProvider);

  if(movies.isEmpty) return [];

  return movies.getRange(0, 6).toList();

});