import 'package:flutter/material.dart';

import 'constants/routes/local_routes.dart';
import 'constants/theme/theme_app.dart';
import 'router_app.dart';
import 'services/service_locator.dart';

void main() {
  serviceLocator();

  runApp(const TractianApp());
}

class TractianApp extends StatefulWidget {
  const TractianApp({super.key});

  @override
  State<TractianApp> createState() => _TractianAppState();
}

class _TractianAppState extends State<TractianApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tractian Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeApp.lightTheme,
      navigatorKey: locator<GlobalKey<NavigatorState>>(),
      initialRoute: LocalRoutes.SPLASH,
      onGenerateRoute: RouterApp.onGenerateRoute,
    );
  }
}
