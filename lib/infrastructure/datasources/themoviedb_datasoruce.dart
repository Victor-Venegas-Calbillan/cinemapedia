import 'package:dio/dio.dart';
import 'package:cinema_app/infrastructure/mappers/movie_mapper.dart';
import 'package:cinema_app/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:cinema_app/config/constants/environment.dart';
import 'package:cinema_app/domain/datasources/movies_datasource.dart';
import 'package:cinema_app/domain/entities/movie.dart';

class MovieDbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.movieDbKey,
      'language': 'es-MX'
    }
  ));

  List<Movie> _jsonToMovies(Map<String, dynamic> json){
    final List<Movie> movies = MovieDbResponse.fromJson(json)
    .results
    .where((moviedb) => moviedb.posterPath != 'no-poster')
    .map(
      (moviedb) => MovieMapper.movieDbToEntity(moviedb)
    ).toList();

    return movies;

  }

  @override
  Future<List<Movie>> getNowPLaying({int page = 1}) async {

    final response = await dio.get('/movie/now_playing', 
      queryParameters: {
        'page': page,
      } 
    );
    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) async{

    final response =  await dio.get('/movie/popular', 
    queryParameters: {
      'page': page,
    });

    return _jsonToMovies(response.data);

  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response =  await dio.get('/movie/top_rated', 
    queryParameters: {
      'page': page,
    });

    return _jsonToMovies(response.data);

  }
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async{
    final response =  await dio.get('/movie/upcoming', 
    queryParameters: {
      'page': page,
    });

    return _jsonToMovies(response.data);
  }
}