import 'package:cinema_app/infrastructure/datasources/actor_moviedb_datasoruce.dart';
import 'package:cinema_app/infrastructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorRepositoryProvider = Provider((ref){
  return ActorRepositoryImpl( ActorMovieDbDatasource() );
});