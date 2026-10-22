import 'package:flutter/widgets.dart';

/// Efek "ditekan": mengecil sedikit selama pointer turun, kembali dalam 90ms.
///
/// Memakai [Listener] (bukan GestureDetector) supaya gesture child - InkWell,
/// scroll, dsb - tetap utuh. Tombol di dalam kartu yang sama-sama memakai
/// PressScale akan mengecil bertumpuk (0.97 x 0.97); masih wajar, tapi kalau
/// terasa berlebihan turunkan [scale] kartu ke 0.985.
class PressScale extends StatefulWidget {
  const PressScale({
    super.key,
    required this.child,
    this.enabled = true,
    this.scale = 0.97,
    this.duration = const Duration(milliseconds: 90),
  });

  final Widget child;

  /// False = tidak ada animasi (dipakai untuk kartu/tombol non-aktif).
  final bool enabled;

  /// Skala saat ditekan, misal 0.97 = mengecil 3%.
  final double scale;

  final Duration duration;

  @override
  State<PressScale> createState() => _PressScaleState();
}

class _PressScaleState extends State<PressScale> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (!widget.enabled || _pressed == value) {
      return;
    }
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (PointerDownEvent event) => _setPressed(true),
      onPointerUp: (PointerUpEvent event) => _setPressed(false),
      onPointerCancel: (PointerCancelEvent event) => _setPressed(false),
      child: AnimatedScale(
        scale: _pressed ? widget.scale : 1,
        duration: widget.duration,
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}
