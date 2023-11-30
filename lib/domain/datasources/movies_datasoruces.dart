import 'package:cinemapedia/domain/entities/movies.dart';

abstract class MoviesDatasoruce {
  Future<List<Movie>> getNowPlaying({ int page = 1});
  Future<List<Movie>> getPopular({ int page = 1});
  Future<List<Movie>> getUpcoming({ int page = 1 });
}