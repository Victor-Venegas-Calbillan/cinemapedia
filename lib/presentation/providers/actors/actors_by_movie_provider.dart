import 'package:cinema_app/domain/entities/actor.dart';
import 'package:cinema_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorByMovieProvider = StateNotifierProvider<ActorByMoviesNotifier, Map<String, List<Actor>>>((ref){
  final actorRepository = ref.watch(actorRepositoryProvider).getActorsByMovie;

  return ActorByMoviesNotifier(getActors: actorRepository);
  
});

typedef GetActorsCallback = Future<List<Actor>>Function(String movieId);


class ActorByMoviesNotifier extends StateNotifier<Map<String, List<Actor>>>{

  final GetActorsCallback getActors;

  ActorByMoviesNotifier({
    required this.getActors,
  }): super({});

  Future<void> loadActor( String movieId) async {
    if(state[movieId] != null) return;

    final actors = await getActors(movieId); 

    state = {...state, movieId: actors};
  }
  
}