import 'package:flutter/material.dart';

import 'constants/routes/local_routes.dart';
import 'models/company/company_model.dart';
import 'views/assets/assets_view.dart';
import 'views/home/home_screen_view.dart';
import 'views/splash/splash_screen_view.dart';

/// Manages application routes
class RouterApp {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LocalRoutes.SPLASH:
        return _PageBuilder(
          child: const SplashScreenView(),
          settings: settings,
        );

      case LocalRoutes.HOME:
        return _PageBuilder(
          child: const HomeScreenView(),
          settings: settings,
        );

      case LocalRoutes.ASSETS:
        final company = settings.arguments as CompanyModel;

        return _PageBuilder(
          child: AssetsView(company: company),
          settings: settings,
        );

      default:
        return _PageBuilder(
          child: const SizedBox(),
          settings: settings,
        );
    }
  }
}

/// Responsible for the transition effect between screens
class _PageBuilder extends PageRouteBuilder {
  _PageBuilder({
    required this.child,
    required this.settings,
  }) : super(
          settings: settings,
          reverseTransitionDuration: const Duration(milliseconds: 200),
          transitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, secAnimation, child) {
            var scaleTween = Tween<double>(begin: 0.9, end: 1.0).chain(CurveTween(curve: Curves.fastOutSlowIn));

            var fadeTween = Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeIn));

            var scaleAnimation = animation.drive(scaleTween);
            var fadeAnimation = animation.drive(fadeTween);

            return GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: FadeTransition(
                opacity: fadeAnimation,
                child: ScaleTransition(
                  scale: scaleAnimation,
                  child: child,
                ),
              ),
            );
          },
          pageBuilder: (context, animation, secAnimation) => child,
        );

  final Widget child;

  @override
  final RouteSettings settings;
}
