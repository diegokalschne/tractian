import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/assets/assets_path.dart';
import '../../constants/routes/local_routes.dart';
import '../../widgets/animations/pulse_animation.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(LocalRoutes.HOME, (_) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: PulseAnimation(
            pulseDurationMs: 700,
            child: SvgPicture.asset(
              AssetsPath.LOGO_TRACTIAN,
              width: size.width * 0.8,
              height: size.height * 0.4,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );
  }
}
