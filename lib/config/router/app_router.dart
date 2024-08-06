import 'package:cinema_app/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRotuer = GoRouter(
  initialLocation: '/home/0',
  routes: [
  GoRoute(
    path: '/home/:page',
    name: HomeScreen.routeName,
    builder: (context, state) {
      final pageIndex = int.parse(state.pathParameters['page'] ?? '0');

      if ( pageIndex > 2 || pageIndex < 0) {
        return const HomeScreen(pageIndex: 0);
      }

      return HomeScreen(
        pageIndex: pageIndex,
      );
    },
    routes: [
      GoRoute(
        path: 'movie/:id',
        name: MovieScreen.name,
        builder: (context, state) {
          final movieId = state.pathParameters['id'] ?? 'no-id';
          return MovieScreen(movieId: movieId);
        },
      )
    ],
  ),

  GoRoute(
    path: '/',
    redirect: (context, state) => '/home/0',
  )
]);
