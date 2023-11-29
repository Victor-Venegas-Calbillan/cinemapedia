import 'package:cinemapedia/domain/entities/movies.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDB movidb) => Movie(
    adult: movidb.adult,
    backdropPath: (movidb.backdropPath != '') 
      ? 'https://image.tmdb.org/t/p/w500/${movidb.backdropPath}'
      : 'https://ih1.redbubble.net/image.1027712254.9762/flat,750x,075,f-pad,750x1000,f8f8f8.u2.webp', 
    genreIds: movidb.genreIds.map((e) => e.toString()).toList(), 
    id: movidb.id, 
    originalLanguage: movidb.originalLanguage, 
    originalTitle: movidb.originalTitle,
    overview: movidb.overview,
    popularity: movidb.popularity, 
    posterPath: (movidb.posterPath != '')
    ? 'https://image.tmdb.org/t/p/w500/${movidb.posterPath}'
    : 'no-poster',
    releaseDate: movidb.releaseDate,
    title: movidb.title, 
    video: movidb.video,
    voteAverage: movidb.voteAverage, 
    voteCount: movidb.voteCount
  );
}