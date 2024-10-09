import 'package:flutter/material.dart';

import '../models/errors/error_model.dart';

String? getExtension(String? path) {
  if (path == null) return null;

  RegExp exp = RegExp(r'\.([a-zA-Z0-9]+)$');
  Match? match = exp.firstMatch(path);

  return match?.group(1);
}

bool isInternetError(Object? err) {
  if (err is ErrorModel && err.type == ErrorType.internet) return true;
  return false;
}

bool isNullOrEmpty(String? text) {
  return text == null || (text.trim().isEmpty);
}

Widget clearField({required dynamic value, required VoidCallback onClear, String? tooltip = 'Limpar filtro'}) {
  if (value == null || (value is String && value.isEmpty)) return const SizedBox();

  return IconButton(
    icon: const Icon(Icons.clear),
    onPressed: onClear,
    tooltip: tooltip,
  );
}
