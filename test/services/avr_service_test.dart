import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/services/avr_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('AvrService menjalankan blink.hex dan melaporkan pin 13', () async {
    final AvrService service = AvrService();
    final Completer<int> high = Completer<int>();
    final Completer<int> low = Completer<int>();

    final StreamSubscription<int> subscription = service
        .watchPin(13)
        .listen((int value) {
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
    await low.future.timeout(const Duration(seconds: 5));

    service.stop();
    expect(service.isRunning, isFalse);
    await subscription.cancel();
    await service.dispose();
  });
}
