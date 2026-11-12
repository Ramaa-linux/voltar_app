import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/models/learning_step.dart';
import 'package:voltar/utils/step_icon_resolver.dart';
import 'package:voltar/widgets/app_icon.dart';

void main() {
  group('resolveMateriIcon & resolveStepIcon', () {
    test('memetakan komponen utama ke SVG kustom dan fallback AppIconName', () {
      final StepIconSpec resistor = resolveMateriIcon(
        title: 'Resistor (Cara Menghitung Nilai)',
        id: 'l1_kom_resistor',
      );
      expect(resistor.svgAsset, 'assets/icons/components/resistor.svg');
      expect(resistor.fallbackIcon, AppIconName.zap);

      final StepIconSpec led = resolveMateriIcon(
        title: 'LED (Light Emitting Diode)',
        id: 'l1_kom_led',
      );
      expect(led.svgAsset, 'assets/icons/components/led.svg');
      expect(led.fallbackIcon, AppIconName.lightbulb);

      final StepIconSpec capacitor = resolveMateriIcon(
        title: 'Kapasitor',
        id: 'l1_kom_kapasitor',
      );
      expect(capacitor.svgAsset, 'assets/icons/components/capacitor.svg');
      expect(capacitor.fallbackIcon, AppIconName.battery);

      final StepIconSpec breadboard = resolveMateriIcon(
        title: 'Breadboard',
        id: 'l1_kom_breadboard',
      );
      expect(breadboard.svgAsset, 'assets/icons/components/breadboard.svg');
      expect(breadboard.fallbackIcon, AppIconName.cpu);

      final StepIconSpec tactileSwitch = resolveMateriIcon(
        title: 'Tactile Switch (Push Button)',
        id: 'l1_kom_tactile_switch',
      );
      expect(tactileSwitch.svgAsset, 'assets/icons/components/switch.svg');
      expect(tactileSwitch.fallbackIcon, AppIconName.play);

      final StepIconSpec ohm = resolveMateriIcon(
        title: 'Hukum Ohm',
        id: 'l1_kom_hukum_ohm',
      );
      expect(ohm.svgAsset, 'assets/icons/components/ohm.svg');
      expect(ohm.fallbackIcon, AppIconName.zap);

      final StepIconSpec sensor = resolveMateriIcon(
        title: 'Jenis & Prinsip Kerja Sensor',
        id: 'l3_jenis_prinsip_kerja_sensor',
      );
      expect(sensor.svgAsset, 'assets/icons/components/sensor.svg');
      expect(sensor.fallbackIcon, AppIconName.cpu);

      final StepIconSpec motor = resolveMateriIcon(
        title: 'Jenis Motor: Servo',
        id: 'l4_jenis_motor',
      );
      expect(motor.svgAsset, 'assets/icons/components/motor.svg');
      expect(motor.fallbackIcon, AppIconName.cpu);

      final StepIconSpec sketch = resolveMateriIcon(
        title: 'Struktur Sketch, Variabel & Tipe Data',
        id: 'l2_struktur_sketch',
      );
      expect(sketch.svgAsset, 'assets/icons/components/code.svg');
      expect(sketch.fallbackIcon, AppIconName.fileText);
    });

    test('pencocokan word-boundary tidak salah mengenali substring "led"', () {
      final StepIconSpec knowledge = resolveMateriIcon(
        title: 'Knowledge Base & Called Function',
        id: 'l5_general_topic',
      );
      expect(knowledge.svgAsset, isNull);
      expect(knowledge.fallbackIcon, AppIconName.bookOpen);
    });

    test('memetakan pretest, posttest, dan folder sesuai tipe', () {
      expect(
        resolveStepIcon(
          const LearningStep(
            id: 'pre',
            type: LearningStepType.pretest,
            title: 'Pre-Test',
            description: '',
          ),
        ).fallbackIcon,
        AppIconName.helpCircle,
      );
      expect(
        resolveStepIcon(
          const LearningStep(
            id: 'post',
            type: LearningStepType.posttest,
            title: 'Post-Test',
            description: '',
          ),
        ).fallbackIcon,
        AppIconName.checkSquare,
      );
      expect(
        resolveStepIcon(
          const LearningStep(
            id: 'fld',
            type: LearningStepType.folder,
            title: 'Folder',
            description: '',
          ),
        ).fallbackIcon,
        AppIconName.folder,
      );
    });
  });

  testWidgets(
    'StepIcon merender fallback AppIcon tanpa error saat SVG komponen belum ada',
    (WidgetTester tester) async {
      const LearningStep ledStep = LearningStep(
        id: 'l1_kom_led',
        type: LearningStepType.materi,
        title: 'LED (Light Emitting Diode)',
        description: 'Materi LED',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StepIcon(step: ledStep),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final AppIcon fallback = tester.widget<AppIcon>(find.byType(AppIcon));
      expect(fallback.name, AppIconName.lightbulb);
      expect(tester.takeException(), isNull);
    },
  );
}
