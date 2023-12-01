import 'package:cinemapedia/infrastructure/datasoruces/actor_moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//este respositorio es inmutable
final actorRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl(dataSource:  ActorMovieDBDatasource() );
});