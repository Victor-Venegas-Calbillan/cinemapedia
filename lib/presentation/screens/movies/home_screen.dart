import 'package:cinema_app/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:cinema_app/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinema_app/domain/entities/movie.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);

    if (initialLoading) return const FullScreenLoader();

    final List<Movie> slideShowMovies = ref.watch(movieSlideshowPorvider);
    final List<Movie> nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final List<Movie> popularMovies = ref.watch(popularMoviesProvider);
    final List<Movie> topRatedMovies = ref.watch(topRatedMoviesProvider);
    final List<Movie> upcomingMovies = ref.watch(upcomingMoviesProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(),
          title: CustomAppbar(),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
          childCount: 1,
          (context, index) {
            return Column(
              children: [
    
                MovieSlideshow(movies: slideShowMovies),
                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'En cines',
                  subTitle: 'Lunes 20',
                  loadNextPage: () =>
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                ),
    
                MovieHorizontalListview(
                  movies: upcomingMovies,
                  title: 'Proximamente',
                  subTitle: 'En este mes',
                  loadNextPage: () =>
                    ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
                ),
    
                MovieHorizontalListview(
                  movies: popularMovies,
                  title: 'Populares',
                  // subTitle: '',
                  loadNextPage: () =>
                    ref.read(popularMoviesProvider.notifier).loadNextPage(),
                ),
    
                MovieHorizontalListview(
                  movies: topRatedMovies,
                  title: 'Mejor calificadas',
                  subTitle: 'desde siempre',
                  loadNextPage: () =>
                    ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
                ),
                const SizedBox( height: 30 ),
              ],
            );
         },
        )
      )
    ]);
  }
}
