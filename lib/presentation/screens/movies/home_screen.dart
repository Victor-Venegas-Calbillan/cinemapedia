import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/presentation/widget/widgets.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: _HomeView()),
      bottomNavigationBar: CustomBottomNavigationBar(),
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
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(intialLoadingProvider);
    if(initialLoading) return const FullScreenLoader();

    final moviesSlideShow = ref.watch(moviesSlideShowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch( upcomingMoviesProvider );
    final topRatingMovies = ref.watch( topRatingMoviesProvider );

    return Visibility(
      visible: !initialLoading,
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: CustomAppBar(),
              titlePadding: EdgeInsets.zero,
            ),
          ),
          SliverList( 
            delegate: SliverChildBuilderDelegate((context, index) {
              return Column(
                children: [
                  MoviesSlideShow(movies: moviesSlideShow),
                  MovieHorizontalListview(
                    movies: nowPlayingMovies,
                    title: 'En cines',
                    subTitle: 'Lunes 20',
                    loadNextPage: () =>
                      ref.read(nowPlayingMoviesProvider.notifier).loadNextPage()
                  ),
                  MovieHorizontalListview(
                    movies: popularMovies,
                    title: 'Populares',
                    // subTitle: '',
                    loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage()
                  ),
                  MovieHorizontalListview(
                    movies: upcomingMovies,
                    title: 'Proximamente',
                    subTitle: 'Este mes',
                    loadNextPage: () => ref.read(upcomingMoviesProvider.notifier).loadNextPage()
                  ),
                  MovieHorizontalListview(
                    movies: topRatingMovies,
                    title: 'Mejor valoradas',
                    // subTitle: 'Este mes',
                    loadNextPage: () => ref.read(upcomingMoviesProvider.notifier).loadNextPage()
                  ),
                ],
              );
            }, 
            childCount: 1),
          ),
        ]
      ),
    );
  }
}
