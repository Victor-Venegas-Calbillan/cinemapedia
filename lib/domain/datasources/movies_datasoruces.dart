import 'package:cinemapedia/domain/entities/movies.dart';

abstract class MovieDatasoruce {
  Future<List<Movie>> getNowPlaying({ int page = 1});
}