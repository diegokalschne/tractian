import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/assets/assets_path.dart';
import 'cs_elevated_button.dart';

class NoWifiWidget extends StatelessWidget {
  const NoWifiWidget({
    this.message = 'Não há conexão com à internet. Verifique o seu wifi ou dados móveis',
    this.callback,
    this.labelCallback = 'TENTAR NOVAMENTE',
    super.key,
  });

  final String message;
  final String labelCallback;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AssetsPath.NO_WIFI_IMAGE,
            width: size.width * 0.8,
            height: size.height * 0.4,
          ),
          const SizedBox(height: 10),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: theme.colorScheme.onSurface,
            ),
          ),
          if (callback != null) ...[
            const SizedBox(height: 10),
            CsElevatedButton.expanded(
              label: labelCallback,
              onPressed: callback,
              alignment: Alignment.center,
            ),
          ],
        ],
      ),
    );
  }
}
