import 'package:cinema_app/config/constants/environment.dart';
import 'package:cinema_app/domain/datasources/actors_datasource.dart';
import 'package:cinema_app/domain/entities/actor.dart';
import 'package:cinema_app/infrastructure/mappers/actor_mapper.dart';
import 'package:cinema_app/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMovieDbDatasource extends ActorsDatasource{


  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.movieDbKey,
      'language': 'es-MX'
    }
  ));


  @override
  Future<List<Actor>> getActorsByMovie(String movieId)  async{
    final response = await dio.get('/movie/$movieId/credits');
    final actors = CreditsResponse.fromJson(response.data)
    .cast.map((cast) => ActorMapper.castToEntity(cast)).toList();

    return actors;
  }

}