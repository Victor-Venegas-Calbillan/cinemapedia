import 'package:cinema_app/infrastructure/datasources/themoviedb_datasoruce.dart';
import 'package:cinema_app/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Este repositorio es inmutable
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl( MovieDbDatasource() );
});
