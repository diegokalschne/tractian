import 'package:flutter/material.dart';

class CsRefreshIndicator extends StatelessWidget {
  const CsRefreshIndicator({
    required this.child,
    required this.onRefresh,
    super.key,
  });

  final Widget child;
  final RefreshCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: onRefresh,
      color: theme.primaryColor,
      child: child,
    );
  }
}
