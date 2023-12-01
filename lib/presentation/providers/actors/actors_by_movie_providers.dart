import 'package:cinemapedia/domain/entities/actors.dart';
import 'package:cinemapedia/presentation/providers/actors/actor_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider = StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>((ref) {
  final actrosRespoitory = ref.watch(actorRepositoryProvider).getActors;
  return ActorsByMovieNotifier(
    getActors: actrosRespoitory,
  );
});


typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {

  final GetActorsCallback  getActors;

  ActorsByMovieNotifier({ required this.getActors }) : super({});

  Future<void> loadActros( movieId ) async {
    if ( state[movieId] != null ) return;

    final List<Actor> actors = await getActors( movieId );

    state = { ...state, movieId: actors };
  }

}