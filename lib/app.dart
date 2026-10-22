import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voltar/router/app_router.dart';
import 'package:voltar/theme/app_theme.dart';

/// Root widget VoltAR.
class VoltArApp extends ConsumerWidget {
  const VoltArApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'VoltAR',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}