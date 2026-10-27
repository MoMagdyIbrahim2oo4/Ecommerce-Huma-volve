import 'package:ecommerce_app_huma_volve/features/details/screens/product_details_screen.dart';
import 'package:ecommerce_app_huma_volve/features/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appRouting = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const SplashScreen();
      },
    ), // GoRoute
    GoRoute(
      path: '/products/:id',
      builder: (context, state) {
        final productId = int.tryParse(state.pathParameters['id'] ?? '');
        if (productId == null) {
          return const _InvalidProductLinkScreen();
        }
        return ProductDetailsScreen(productID: productId);
      },
    ), // GoRoute
  ],
); // GoRouter

class _InvalidProductLinkScreen extends StatelessWidget {
  const _InvalidProductLinkScreen();

  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Center(child: Text('This product link is invalid.')),
  );
}
