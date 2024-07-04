import 'package:cinema_app/domain/datasources/movies_datasource.dart';
import 'package:cinema_app/domain/entities/movie.dart';
import 'package:cinema_app/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository{

  final MoviesDatasource _moviesDatasource;
  MovieRepositoryImpl( MoviesDatasource moviesDatasource) : _moviesDatasource = moviesDatasource;

  @override
  Future<List<Movie>> getNowPLaying({int page = 1}) {
    return _moviesDatasource.getNowPLaying(page: page);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return _moviesDatasource.getPopular(page: page);
  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return _moviesDatasource.getTopRated(page: page);
  }
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return _moviesDatasource.getUpcoming(page: page);
  }
  
  @override
  Future<Movie> getMovieById( String id) {
    return _moviesDatasource.getMovieById(id);
  }


}