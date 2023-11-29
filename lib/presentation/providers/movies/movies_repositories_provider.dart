
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/infrastructure/datasoruces/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';

//este respositorio es inmutable
final moviesRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl( MoviedbDatasource() );
});