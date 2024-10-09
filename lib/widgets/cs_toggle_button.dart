import 'package:flutter/material.dart';

class CsToggleButton extends StatelessWidget {
  const CsToggleButton({
    required this.onToggle,
    required this.toggled,
    required this.label,
    this.height = 40,
    this.alignment = Alignment.centerLeft,
    this.labelAlign,
    this.icon,
    super.key,
  });

  final void Function(bool) onToggle;
  final bool toggled;
  final String label;
  final TextAlign? labelAlign;
  final Widget? icon;
  final double height;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: () {
          onToggle(!toggled);
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((_) {
            if (!toggled) {
              return Colors.white;
            }

            return theme.primaryColor;
          }),
          elevation: WidgetStateProperty.all(5),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
          alignment: alignment,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Theme(
                data: theme.copyWith(
                  iconTheme: IconThemeData(
                    color: toggled ? theme.colorScheme.surface : theme.colorScheme.onSurface,
                  ),
                ),
                child: icon!,
              ),
              const SizedBox(width: 5),
            ],
            Text(
              label,
              textAlign: labelAlign,
              style: TextStyle(
                color: toggled ? theme.colorScheme.surface : theme.colorScheme.onSurface,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
