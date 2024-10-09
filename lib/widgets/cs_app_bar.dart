import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/function_utils.dart';

class CsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CsAppBar({
    required this.title,
    this.centerTitle = true,
    this.color,
    this.subtitle,
    super.key,
  })  : imagePath = null,
        assert(title != null, 'The \'title\' parameter is required');

  const CsAppBar.image({
    required this.imagePath,
    this.centerTitle = true,
    this.color,
    this.subtitle,
    super.key,
  })  : title = null,
        assert(imagePath != null, 'The \'imagePath\' parameter is required');

  final String? title;
  final String? imagePath;
  final bool centerTitle;
  final Color? color;
  final String? subtitle;

  @override
  Size get preferredSize => const Size.fromHeight(65);

  Widget _buildTitle(BuildContext context) {
    final theme = Theme.of(context);

    if (title != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Text(
            title!,
            style: TextStyle(
              color: theme.appBarTheme.foregroundColor,
              fontSize: 20,
            ),
          ),
          if (!isNullOrEmpty(subtitle)) ...[
            Text(
              subtitle!,
              style: TextStyle(
                color: theme.appBarTheme.foregroundColor,
                fontSize: 14,
              ),
            ),
          ],
        ],
      );
    }

    String? ext = getExtension(imagePath)?.toLowerCase();
    if (ext != null) {
      if (['png', 'jpeg', 'jpg'].contains(ext)) {
        return Image.asset(
          imagePath!,
          color: color,
          height: 20,
        );
      }

      if (ext == 'svg') {
        return SvgPicture.asset(
          imagePath!,
          colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
          height: 20,
        );
      }
    }

    return const SizedBox();
  }

  Widget? _buildLeading(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      return IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () {
          Navigator.of(context).maybePop();
        },
        tooltip: 'Voltar',
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: theme.appBarTheme.backgroundColor,
      centerTitle: centerTitle,
      title: _buildTitle(context),
      leading: _buildLeading(context),
    );
  }
}
