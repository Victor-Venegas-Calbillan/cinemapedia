import 'package:cinema_app/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRotuer = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.routeName,
      builder: (context, state) => const HomeScreen(),
    )
  ] 
);