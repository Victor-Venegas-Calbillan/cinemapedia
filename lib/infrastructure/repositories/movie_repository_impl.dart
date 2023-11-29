
import 'package:cinemapedia/domain/datasources/movies_datasoruces.dart';
import 'package:cinemapedia/domain/entities/movies.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository{
  final MoviesDatasoruce moviesDatasoruce;

  MovieRepositoryImpl(this.moviesDatasoruce);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return moviesDatasoruce.getNowPlaying(page: page);
  }

}