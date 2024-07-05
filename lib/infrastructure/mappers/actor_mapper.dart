import 'package:cinema_app/domain/entities/actor.dart';
import 'package:cinema_app/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToEntity (Cast cast) => Actor(
    id: cast.id, 
    name: cast.name, 
    profilePath: cast.profilePath != null
    ?'https://image.tmdb.org/t/p/w500${cast.profilePath}'  
    : 'https://cdn.vectorstock.com/i/500p/15/40/blank-profile-picture-image-holder-with-a-crown-vector-42411540.jpg', 
    character: cast.character
  );
}