import 'package:flutter/material.dart';

import '../utils/function_utils.dart';

class CsInlineInfo extends StatelessWidget {
  const CsInlineInfo({
    required this.text,
    this.label,
    this.isLabelBold = true,
    this.icon,
    this.isTextExpanded = false,
    super.key,
  });

  final String? label;
  final String text;
  final bool isLabelBold;
  final IconData? icon;
  final bool isTextExpanded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon!, color: theme.primaryColor),
          const SizedBox(width: 5),
        ],
        if (!isNullOrEmpty(label)) ...[
          Text(
            label!,
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontWeight: isLabelBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ],
        Flexible(
          fit: isTextExpanded ? FlexFit.tight : FlexFit.loose,
          child: Text(
            text,
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
