import 'package:cinemapedia/domain/entities/movies.dart';

abstract class MoviesDatasoruce {
  Future<List<Movie>> getNowPlaying({ int page = 1});
}