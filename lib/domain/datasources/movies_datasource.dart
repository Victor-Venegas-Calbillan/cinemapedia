import 'package:cinema_app/domain/entities/movie.dart';

abstract class MovieDatasource{ 
  Future<List<Movie>>getNowPLaying({ int page = 1 });
}