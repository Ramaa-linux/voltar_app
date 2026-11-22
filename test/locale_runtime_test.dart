import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/l10n/app_localizations.dart';
import 'package:voltar/repositories/materi_repository.dart';
import 'package:voltar/utils/localization_helper.dart';

void main() {
  testWidgets('Lokalisasi materi berubah saat locale dialihkan dari ID ke EN',
      (WidgetTester tester) async {
    const titleKey = 'materiL1L1KomBreadboardTitle';
    const descKey = 'materiL1L1KomBreadboardDescription';

    String? renderedTitleId;
    String? renderedTitleEn;
    String? renderedDescId;
    String? renderedDescEn;

    // Test 1: Render dengan locale ID
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('id'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: Builder(
          builder: (context) {
            renderedTitleId = context.t(titleKey);
            renderedDescId = context.t(descKey);
            return Container();
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Test 2: Render dengan locale EN
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: Builder(
          builder: (context) {
            renderedTitleEn = context.t(titleKey);
            renderedDescEn = context.t(descKey);
            return Container();
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verifikasi: Kunci ARB menghasilkan string yang berbeda untuk ID dan EN
    expect(renderedTitleId, isNotNull);
    expect(renderedTitleEn, isNotNull);
    expect(renderedDescId, isNotNull);
    expect(renderedDescEn, isNotNull);

    // Title: Breadboard sama di ID dan EN
    expect(renderedTitleId, equals('Breadboard'));
    expect(renderedTitleEn, equals('Breadboard'));

    // Description: berbeda antara ID dan EN
    expect(renderedDescId, contains('papan untuk merangkai'));
    expect(renderedDescEn, contains('board for assembling'));
  });

  testWidgets('MateriRepository men-generate kunci ARB yang valid untuk runtime lookup',
      (WidgetTester tester) async {
    final repo = MateriRepository();
    final level = await repo.getLevelByNumber(1);
    expect(level.steps, isNotEmpty);

    for (final s in level.steps) {
      expect(s.localizedTitleKey, isNotNull);
      expect(s.localizedTitleKey, startsWith('materiL1'));
      expect(s.localizedDescriptionKey, isNotNull);
    }
  });
}