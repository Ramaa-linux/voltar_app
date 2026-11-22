import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voltar/l10n/app_localizations.dart';
import 'package:voltar/providers/locale_provider.dart';
import 'package:voltar/router/app_router.dart';
import 'package:voltar/theme/app_theme.dart';

/// Alias kompatibilitas nama root widget.
typedef VoltarApp = VoltArApp;

/// Root widget EduVolt.
class VoltArApp extends ConsumerWidget {
  const VoltArApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    return MaterialApp.router(
      title: 'EduVolt',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      locale: locale.locale,
      supportedLocales: locale.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}