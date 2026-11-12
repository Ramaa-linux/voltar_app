import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voltar/widgets/spark_particle_system.dart';

void main() {
  group('SparkParticle', () {
    test('t menghitung progres umur dan diclamp antara 0.0 dan 1.0', () {
      final SparkParticle particle = SparkParticle(
        age: 0.25,
        lifetime: 0.5,
        dead: false,
      );
      expect(particle.t, closeTo(0.5, 0.001));
      expect(particle.isAlive, isTrue);

      particle.age = 0.6;
      expect(particle.t, 1.0);
      expect(particle.isAlive, isFalse);

      particle.dead = true;
      expect(particle.isAlive, isFalse);
    });
  });

  group('SparkParticleSystem', () {
    test('memancarkan partikel sesuai emissionRate * dt', () {
      final SparkParticleSystem system = SparkParticleSystem(
        config: const SparkParticleConfig(emissionRate: 50.0, maxParticles: 100),
        random: math.Random(1234),
      );

      expect(system.activeCount, 0);

      // dt = 0.04s -> 50 * 0.04 = 2.0 partikel
      system.update(0.04, const Offset(50, 10), emitting: true);
      expect(system.activeCount, 2);

      // dt = 0.02s -> 50 * 0.02 = 1.0 partikel lagi
      system.update(0.02, const Offset(50, 10), emitting: true);
      expect(system.activeCount, 3);
    });

    test('tidak melebihi maxParticles saat pool penuh', () {
      const int maxLimit = 10;
      final SparkParticleSystem system = SparkParticleSystem(
        config: const SparkParticleConfig(
          maxParticles: maxLimit,
          emissionRate: 500.0,
          minLifetime: 5.0,
          maxLifetime: 10.0,
        ),
        random: math.Random(42),
      );

      // Jalankan beberapa frame emisi tinggi
      for (int i = 0; i < 10; i++) {
        system.update(0.05, const Offset(100, 20), emitting: true);
      }

      expect(system.activeCount, lessThanOrEqualTo(maxLimit));
    });

    test('partikel mati alami saat age >= lifetime dan slot di-reuse', () {
      final SparkParticleSystem system = SparkParticleSystem(
        config: const SparkParticleConfig(
          emissionRate: 20.0,
          minLifetime: 0.1,
          maxLifetime: 0.1,
        ),
        random: math.Random(99),
      );

      // Emisi partikel
      system.update(0.05, const Offset(10, 10), emitting: true);
      expect(system.activeCount, greaterThan(0));

      // Majukan waktu melampaui lifetime tanpa emisi baru
      system.update(0.05, const Offset(10, 10), emitting: false);
      system.update(0.05, const Offset(10, 10), emitting: false);
      system.update(0.05, const Offset(10, 10), emitting: false);

      expect(system.activeCount, 0);

      // Emisi lagi setelah semua mati -> slot pool dipakai kembali
      system.update(0.05, const Offset(10, 10), emitting: true);
      expect(system.activeCount, 1);
    });

    test('clamping maxDt mencegah lonjakan emisi dan teleportasi posisi', () {
      final SparkParticleSystem system = SparkParticleSystem(
        config: const SparkParticleConfig(
          emissionRate: 100.0,
          maxDt: 0.05,
          minLifetime: 1.0,
          maxLifetime: 1.0,
        ),
        random: math.Random(1),
      );

      // dt ekstrim 10 detik (mis. lag frame) harus diclamp ke 0.05s (100 * 0.05 = 5 partikel)
      system.update(10.0, const Offset(0, 0), emitting: true);
      expect(system.activeCount, 5);
    });

    test('gravitasi dan drag eksponensial memengaruhi kecepatan', () {
      final SparkParticleSystem system = SparkParticleSystem(
        config: const SparkParticleConfig(
          emissionRate: 20.0,
          gravity: 200.0,
          drag: 0.5,
          minLifetime: 1.0,
          maxLifetime: 1.0,
          minSpeed: 100.0,
          maxSpeed: 100.0,
          minAngle: 0.0,
          maxAngle: 0.0,
        ),
        random: math.Random(42),
      );

      // Emisi 1 partikel
      system.update(0.05, const Offset(0, 0), emitting: true);
      final SparkParticle particle = system.activeParticles.first;
      final double initialVx = particle.vx;
      final double initialVy = particle.vy;

      // Update frame berikutnya
      system.update(0.05, const Offset(0, 0), emitting: false);

      // vx meluruh karena drag
      expect(particle.vx, lessThan(initialVx));
      // vy bertambah ke bawah karena gravitasi
      expect(particle.vy, greaterThan(initialVy));
    });

    test('reset membersihkan seluruh partikel aktif dan akumulator', () {
      final SparkParticleSystem system = SparkParticleSystem(
        config: const SparkParticleConfig(emissionRate: 50.0),
        random: math.Random(7),
      );

      system.update(0.04, const Offset(10, 10), emitting: true);
      expect(system.activeCount, greaterThan(0));

      system.reset();
      expect(system.activeCount, 0);
      expect(system.activeParticles.isEmpty, isTrue);
    });

    test('colorAt mengembalikan gradasi warna valid dari 0.0 hingga 1.0', () {
      const Color sparkColor = Color(0xFFFFC107);
      final Color startColor = SparkParticleSystem.colorAt(0.0, sparkColor: sparkColor);
      final Color midColor = SparkParticleSystem.colorAt(0.4, sparkColor: sparkColor);
      final Color endColor = SparkParticleSystem.colorAt(1.0, sparkColor: sparkColor);

      expect(startColor.a, 1.0);
      expect(startColor.r, greaterThanOrEqualTo(0.9));
      expect(midColor.a, greaterThan(0.5));
      // Akhir masa hidup memudar ke transparan
      expect(endColor.a, closeTo(0.0, 0.01));
    });

    test('sizeAt mengecil seiring bertambahnya t', () {
      final double s0 = SparkParticleSystem.sizeAt(0.0, 3.0);
      final double sHalf = SparkParticleSystem.sizeAt(0.5, 3.0);
      final double sEnd = SparkParticleSystem.sizeAt(1.0, 3.0);

      expect(s0, 3.0);
      expect(sHalf, lessThan(s0));
      expect(sEnd, closeTo(0.0, 0.001));
    });
  });
}
