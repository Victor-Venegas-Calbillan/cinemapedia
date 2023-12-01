import 'package:cinemapedia/domain/entities/actors.dart';

abstract class ActorsRepository {
  Future<List<Actor>> getActors(String movieId);
}
