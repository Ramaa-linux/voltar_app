import 'package:flutter/material.dart';

/// Feedback sementara untuk fitur yang belum aktif (Fase 4+).
///
/// Memakai SnackBar tema global: latar [AppColors.textPrimary], teks putih.
void showVoltSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
