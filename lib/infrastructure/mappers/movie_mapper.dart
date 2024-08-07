import 'package:cinema_app/domain/entities/movie.dart';
import 'package:cinema_app/infrastructure/models/modesl.dart';

class MovieMapper {
  static Movie movieDbToEntity (MovieMovieDB moviedb) =>
  Movie(
    adult: moviedb.adult, 
    backdropPath: moviedb.backdropPath != '' 
      ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
      : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg', 
    genreIds: moviedb.genreIds.map((e)=> e.toString()).toList(), 
    id: moviedb.id, 
    originalLanguage: moviedb.originalLanguage, 
    originalTitle: moviedb.originalTitle, 
    overview: moviedb.overview, 
    popularity: moviedb.popularity, 
    posterPath: moviedb.posterPath != '' 
    ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
    : 'https://ih1.redbubble.net/image.4444864572.3099/fposter,small,wall_texture,square_product,600x600.jpg', 
    releaseDate: moviedb.releaseDate != null
    ? moviedb.releaseDate! 
    : DateTime.now(), 
    title: moviedb.title, 
    video: moviedb.video, 
    voteAverage: moviedb.voteAverage, 
    voteCount: moviedb.voteCount
  );


  static Movie movieDetailsEntity (MovieDetails moviedb) =>
  Movie(
    adult: moviedb.adult, 
    backdropPath: moviedb.backdropPath != '' 
      ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
      : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg', 
    genreIds: moviedb.genres.map((e)=> e.name).toList(), 
    id: moviedb.id, 
    originalLanguage: moviedb.originalLanguage, 
    originalTitle: moviedb.originalTitle, 
    overview: moviedb.overview, 
    popularity: moviedb.popularity, 
    posterPath: moviedb.posterPath != '' 
    ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
    : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg', 
    releaseDate: moviedb.releaseDate, 
    title: moviedb.title, 
    video: moviedb.video, 
    voteAverage: moviedb.voteAverage, 
    voteCount: moviedb.voteCount
  );
}