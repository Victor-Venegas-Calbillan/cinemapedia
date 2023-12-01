import 'package:cinemapedia/domain/entities/actors.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {

  static Actor castToEntity(Cast cast) => Actor(
    id: cast.id, 
    name: cast.name, 
    profilePath: cast.profilePath != null 
    ?'https://image.tmdb.org/t/p/w500${cast.profilePath}'
    :'https://cdn.vectorstock.com/i/preview-1x/15/40/blank-profile-picture-image-holder-with-a-crown-vector-42411540.jpg' ,
    character: cast.character 
  );
}