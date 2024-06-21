import 'package:cinema_app/domain/entities/movie.dart';

abstract class MovieRepository{ 
  Future<List<Movie>>getNowPLaying({ int page = 1 });
}