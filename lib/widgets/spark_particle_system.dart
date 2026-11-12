import 'dart:math' as math;
import 'package:flutter/material.dart';

/// State partikel tunggal percikan las.
class SparkParticle {
  SparkParticle({
    this.x = 0.0,
    this.y = 0.0,
    this.vx = 0.0,
    this.vy = 0.0,
    this.age = 0.0,
    this.lifetime = 1.0,
    this.startSize = 2.0,
    this.dead = true,
  });

  double x;
  double y;
  double vx;
  double vy;
  double age;
  double lifetime;
  double startSize;
  bool dead;

  /// Rasio progres umur partikel: 0.0 (baru lahir) hingga 1.0 (mati).
  double get t => lifetime > 0.0 ? (age / lifetime).clamp(0.0, 1.0) : 1.0;

  /// Partikel aktif jika belum ditandai mati dan belum melewati lifetime.
  bool get isAlive => !dead && age < lifetime;
}

/// Konfigurasi fisika dan emisi sistem partikel percikan las.
class SparkParticleConfig {
  const SparkParticleConfig({
    this.maxParticles = 75,
    this.emissionRate = 70.0,
    this.minLifetime = 0.35,
    this.maxLifetime = 0.85,
    this.minSpeed = 60.0,
    this.maxSpeed = 150.0,
    this.gravity = 220.0,
    this.drag = 0.3,
    this.minAngle = -75.0 * math.pi / 180.0,
    this.maxAngle = 75.0 * math.pi / 180.0,
    this.minStartSize = 1.2,
    this.maxStartSize = 2.6,
    this.maxDt = 0.05,
    this.jitterX = 1.0,
    this.jitterY = 1.5,
    this.streakSpeedThreshold = 40.0,
    this.streakLengthFactor = 0.035,
  });

  final int maxParticles;
  final double emissionRate;
  final double minLifetime;
  final double maxLifetime;
  final double minSpeed;
  final double maxSpeed;
  final double gravity;
  final double drag;
  final double minAngle;
  final double maxAngle;
  final double minStartSize;
  final double maxStartSize;
  final double maxDt;
  final double jitterX;
  final double jitterY;
  final double streakSpeedThreshold;
  final double streakLengthFactor;
}


/// Sistem simulasi fisika percikan las dengan pooling dan emisi berbasis dt.
class SparkParticleSystem {
  SparkParticleSystem({
    this.config = const SparkParticleConfig(),
    math.Random? random,
  })  : _random = random ?? math.Random(),
        _pool = List<SparkParticle>.generate(
          config.maxParticles,
          (_) => SparkParticle(),
          growable: false,
        );

  final SparkParticleConfig config;
  final math.Random _random;
  final List<SparkParticle> _pool;
  double _emitAccumulator = 0.0;

  /// Seluruh partikel aktif saat ini.
  Iterable<SparkParticle> get activeParticles sync* {
    for (final SparkParticle p in _pool) {
      if (p.isAlive) yield p;
    }
  }

  /// Total partikel yang sedang aktif.
  int get activeCount {
    int count = 0;
    for (final SparkParticle p in _pool) {
      if (p.isAlive) count++;
    }
    return count;
  }

  /// Update simulasi partikel per frame.
  ///
  /// Memperbarui umur, posisi, drag eksponensial, gravitasi, dan memancarkan
  /// partikel baru di [emitter] jika [emitting] bernilai true.
  void update(double dt, Offset emitter, {required bool emitting}) {
    final double safeDt = dt.clamp(0.0, config.maxDt);
    if (safeDt <= 0.0) return;

    final double decay = math.pow(config.drag, safeDt).toDouble();

    // 1. Update partikel hidup
    for (final SparkParticle p in _pool) {
      if (!p.isAlive) continue;

      p.age += safeDt;
      if (p.age >= p.lifetime) {
        p.dead = true;
        continue;
      }

      // Drag udara + gravitasi
      p.vx *= decay;
      p.vy = (p.vy * decay) + (config.gravity * safeDt);

      p.x += p.vx * safeDt;
      p.y += p.vy * safeDt;
    }

    // 2. Emisi partikel baru
    if (emitting) {
      _emitAccumulator += config.emissionRate * safeDt;
      final int toEmit = _emitAccumulator.floor();
      _emitAccumulator -= toEmit;

      for (int i = 0; i < toEmit; i++) {
        _spawnParticle(emitter);
      }
    } else {
      _emitAccumulator = 0.0;
    }
  }

  void _spawnParticle(Offset emitter) {
    // Cari slot partikel yang mati dari pool
    SparkParticle? target;
    for (final SparkParticle p in _pool) {
      if (!p.isAlive) {
        target = p;
        break;
      }
    }
    if (target == null) return; // Pool penuh

    final double angle = config.minAngle +
        _random.nextDouble() * (config.maxAngle - config.minAngle);
    final double speed = config.minSpeed +
        _random.nextDouble() * (config.maxSpeed - config.minSpeed);

    final double jx = (_random.nextDouble() * 2.0 - 1.0) * config.jitterX;
    final double jy = (_random.nextDouble() * 2.0 - 1.0) * config.jitterY;

    target.x = emitter.dx + jx;
    target.y = emitter.dy + jy;
    target.vx = math.cos(angle) * speed;
    target.vy = math.sin(angle) * speed;
    target.age = 0.0;
    target.lifetime = config.minLifetime +
        _random.nextDouble() * (config.maxLifetime - config.minLifetime);
    target.startSize = config.minStartSize +
        _random.nextDouble() * (config.maxStartSize - config.minStartSize);
    target.dead = false;
  }

  /// Bersihkan seluruh partikel dan reset akumulator.
  void reset() {
    _emitAccumulator = 0.0;
    for (final SparkParticle p in _pool) {
      p.dead = true;
      p.age = 0.0;
    }
  }

  /// Warna partikel pada progres [t] (0.0 baru lahir -> 1.0 mati).
  ///
  /// Transisi: Putih pijar (hotspot) -> Kuning keemasan -> Oranye -> Merah redup transparan.
  static Color colorAt(double t, {Color? sparkColor}) {
    final double progress = t.clamp(0.0, 1.0);
    final Color accent = sparkColor ?? const Color(0xFFFFC107);

    if (progress < 0.20) {
      final double localT = progress / 0.20;
      return Color.lerp(
        const Color(0xFFFFFFFF),
        const Color(0xFFFFF9C4),
        localT,
      )!;
    } else if (progress < 0.55) {
      final double localT = (progress - 0.20) / 0.35;
      return Color.lerp(
        const Color(0xFFFFE082),
        accent,
        localT,
      )!.withValues(alpha: 1.0 - (localT * 0.15));
    } else {
      final double localT = (progress - 0.55) / 0.45;
      final Color endRed = Color.lerp(
        const Color(0xFFFF7043),
        const Color(0xFFD32F2F),
        localT,
      )!;
      return endRed.withValues(alpha: (0.85 * (1.0 - localT)).clamp(0.0, 1.0));
    }
  }

  /// Ukuran radius partikel mengecil secara non-linear terhadap umur [t].
  static double sizeAt(double t, double startSize) {
    final double progress = t.clamp(0.0, 1.0);
    return startSize * math.pow(1.0 - progress, 0.7);
  }
}

