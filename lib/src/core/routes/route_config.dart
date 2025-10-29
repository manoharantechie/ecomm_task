import 'package:e_comm/src/core/routes/route_path.dart';
import 'package:e_comm/src/features/data/product_list_model.dart';
import 'package:e_comm/src/features/presentation/pages/dash_screen.dart';
import 'package:e_comm/src/features/presentation/pages/home_screen.dart';
import 'package:e_comm/src/features/presentation/pages/product/cart_screen.dart';
import 'package:e_comm/src/features/presentation/pages/product/product_details_screen.dart';
import 'package:e_comm/src/features/presentation/pages/product/product_list_screen.dart';
import 'package:e_comm/src/features/presentation/pages/splash_screen.dart';
import 'package:go_router/go_router.dart';


class AppRouteConf {
  GoRouter get router => _router;

  late final _router = GoRouter(
    initialLocation: AppRoute.splash.path,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoute.splash.path,
        name: AppRoute.splash.name,
        builder: (_, __) => const SplashScreen(),
        routes: [

          GoRoute(
            path: AppRoute.home.path,
            name: AppRoute.home.name,
            builder: (context, state) => HomeScreen(

            ),
          ),
          GoRoute(
            path: AppRoute.dashboard.path,
            name: AppRoute.dashboard.name,
            builder: (_, __) => DashScreen(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoute.productlist.path,
        name: AppRoute.productlist.name,
        builder: (_, __) => ProductListScreen(),
      ),
      GoRoute(
        path: AppRoute.cart.path,
        name: AppRoute.cart.name,
        builder: (_, __) => CartPage(),
      ),
      GoRoute(
          path: AppRoute.productdetails.path,
          name: AppRoute.productdetails.name,
          builder: (context, state) {
            final data = state.extra as Map<String, ProductListModel>;
            final account = data['details'];
            return ProductDetailsScreen(
              details: account!,
            );
          }),


    ],
  );
}
