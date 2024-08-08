import 'package:animate_do/animate_do.dart';
import 'package:cinema_app/domain/entities/movie.dart';
import 'package:cinema_app/presentation/providers/movies/movie_info_provider.dart';
import 'package:cinema_app/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie_screen';
  final String movieId;

  const MovieScreen({
    super.key, 
    required this.movieId
  });

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {

  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorByMovieProvider.notifier).loadActor(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId]; 

    if(movie == null){ 
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(strokeWidth: 2)
        )
      );
    }
    
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppbar(movie: movie),
          SliverList(
            delegate: SliverChildBuilderDelegate(
             (context, index) => _MovieDetails(movie: movie), 
             childCount: 1
            )
          )
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;

  const _MovieDetails({ required this.movie});

  @override
  Widget build(BuildContext context) {

    final titleStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  movie.posterPath, 
                  width: size.width * 0.3,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: (size.width - 40) * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: titleStyles.titleLarge,),
                    Text(movie.overview) 
                  ],
                ),
              )
            ],
          ),
        ),
        //generos de la pelicula 
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map((gender) => Container(
                margin: const EdgeInsets.only(right: 10),
                child: Chip(
                  label: Text(gender),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ))
            ],
          ),
        ),
        _ActorsByMovie(movieId: movie.id.toString()),
        const SizedBox(height: 30),
      ],
    );
  }
}

class _ActorsByMovie  extends ConsumerWidget {
  final String movieId;
  
  const _ActorsByMovie ({ required this.movieId});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final actorsByMovie = ref.watch(actorByMovieProvider);

    if( actorsByMovie[movieId] == null) {
      return const CircularProgressIndicator(strokeWidth: 2,);
    }

    final actors = actorsByMovie[movieId]!;
    

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index){
          final actor = actors[index];

          return Container(
            padding: const EdgeInsets.all(8),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //actor photo
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      actor.profilePath,
                      width: 135,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                Text(actor.name, maxLines: 2),
                Text(
                  actor.character ?? '', 
                  maxLines: 2,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold, 
                    overflow: TextOverflow.ellipsis
                  ),
                )
                //nombre
              ],
            ),
          );
        }
      ),
    );
  }
}

class _CustomSliverAppbar extends StatelessWidget {
  final Movie movie;

  const _CustomSliverAppbar({ required this.movie });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      actions: [
        IconButton(
          icon: Icon(Icons.favorite_border),
          // icon: const Icon(Icons.favorite_rounded, color: Colors.red,),
          onPressed: (){
            //todo: Realizar toggle
          },
        ),
      ],
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        background: _BackgroundImage(movie: movie),
      ), 
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.network(
            movie.posterPath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if(loadingProgress != null) return const SizedBox();

              return FadeIn(child: child);
            },
          ),
        ),
        const _CustomGradient(
          colors: [Colors.transparent, Colors.black87], 
          being: Alignment.topCenter, 
          end: Alignment.bottomCenter,
          stops: [0.8, 1.0]
        ),
        const _CustomGradient(
          colors: [Colors.black87, Colors.transparent], 
          being: Alignment.topLeft, 
          end: Alignment.bottomCenter,
          stops: [0.0, 0.15]
        ),
        const _CustomGradient(
          colors: [Colors.black87, Colors.transparent], 
          being: Alignment.topRight, 
          end: Alignment.bottomLeft, 
          stops: [0.0, 0.15]
        ),
      ],
    );
  }
}

class _CustomGradient extends StatelessWidget {

  final List<Color> colors;
  final List<double> stops;
  final AlignmentGeometry being;
  final AlignmentGeometry end;

  const _CustomGradient({
    required this.colors, 
    required this.being, 
    required this.end, 
    required this.stops
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: being,
            end: end,
            stops: stops,
            colors:colors
          )
        )
      ),
    );
  }
}

