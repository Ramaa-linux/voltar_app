import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/services/avr_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('AvrService menjalankan blink.hex dan melaporkan pin 13', () async {
    final AvrService service = AvrService();
    final Completer<int> high = Completer<int>();
    final Completer<int> low = Completer<int>();

    final StreamSubscription<int> subscription = service.watchPin(13).listen((
      int value,
    ) {
      if (value == 1 && !high.isCompleted) {
        high.complete(value);
      }
      if (value == 0 && !low.isCompleted) {
        low.complete(value);
      }
    });

    await service.start();
    expect(service.isRunning, isTrue);

    // HIGH muncul segera, LOW setelah delay 1 detik simulasi.
    await high.future.timeout(const Duration(seconds: 5));
    expect(service.pinValue(13), 1);
    await low.future.timeout(const Duration(seconds: 5));
    expect(service.pinValue(13), 0);

    service.stop();
    expect(service.isRunning, isFalse);
    await subscription.cancel();
    await service.dispose();
  });

  test(
    'AvrService menyiarkan pin ke semua listener dan start() idempoten',
    () async {
      final AvrService service = AvrService();
      final Completer<int> first = Completer<int>();
      final Completer<int> second = Completer<int>();

      final StreamSubscription<int> subA = service.watchPin(13).listen((
        int value,
      ) {
        if (value == 1 && !first.isCompleted) {
          first.complete(value);
        }
      });
      final StreamSubscription<int> subB = service.watchPin(13).listen((
        int value,
      ) {
        if (value == 1 && !second.isCompleted) {
          second.complete(value);
        }
      });

      // Dua start() beruntun tidak boleh menumbuhkan isolate kedua.
      await Future.wait(<Future<void>>[service.start(), service.start()]);
      expect(service.isRunning, isTrue);

      final int value = await first.future.timeout(const Duration(seconds: 5));
      expect(value, 1);
      expect(await second.future.timeout(const Duration(seconds: 5)), 1);
      expect(service.pinValue(13), 1);

      service.stop();
      expect(service.isRunning, isFalse);
      await subA.cancel();
      await subB.cancel();
      await service.dispose();
    },
  );
}
