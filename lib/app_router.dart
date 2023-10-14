import 'package:go_router/go_router.dart';
import 'package:promenade/features/main/pages/main_screen.dart';

class AppRouter {
  final GoRouter router = GoRouter(
    initialLocation: '/main-screen',
    routes: [
      GoRoute(
        name: 'mainScreen',
        path: '/main-screen',
        builder: (context, state) => const MainScreen(),
      ),
    ],
  );
}
