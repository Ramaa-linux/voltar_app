import 'package:flutter/material.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/volt_card.dart';

enum BandType { digit, multiplier, tolerance, tempco }

class ResistorColorDef {
  const ResistorColorDef({
    required this.name,
    required this.color,
    this.digit,
    this.multiplier,
    this.multiplierLabel,
    this.tolerance,
    this.tempco,
    this.textColor = Colors.white,
  });

  final String name;
  final Color color;
  final int? digit;
  final double? multiplier;
  final String? multiplierLabel;
  final double? tolerance;
  final int? tempco;
  final Color textColor;
}

const List<ResistorColorDef> kResistorColors = <ResistorColorDef>[
  ResistorColorDef(
    name: 'Hitam',
    color: Color(0xFF000000),
    digit: 0,
    multiplier: 1,
    multiplierLabel: '×1',
  ),
  ResistorColorDef(
    name: 'Cokelat',
    color: Color(0xFF8B4513),
    digit: 1,
    multiplier: 10,
    multiplierLabel: '×10',
    tolerance: 1,
    tempco: 100,
  ),
  ResistorColorDef(
    name: 'Merah',
    color: Color(0xFFEF4444),
    digit: 2,
    multiplier: 100,
    multiplierLabel: '×100',
    tolerance: 2,
    tempco: 50,
  ),
  ResistorColorDef(
    name: 'Oranye',
    color: Color(0xFFF97316),
    digit: 3,
    multiplier: 1000,
    multiplierLabel: '×1k',
    tempco: 15,
  ),
  ResistorColorDef(
    name: 'Kuning',
    color: Color(0xFFEAB308),
    digit: 4,
    multiplier: 10000,
    multiplierLabel: '×10k',
    tempco: 25,
    textColor: Colors.black,
  ),
  ResistorColorDef(
    name: 'Hijau',
    color: Color(0xFF22C55E),
    digit: 5,
    multiplier: 100000,
    multiplierLabel: '×100k',
    tolerance: 0.5,
  ),
  ResistorColorDef(
    name: 'Biru',
    color: Color(0xFF3B82F6),
    digit: 6,
    multiplier: 1000000,
    multiplierLabel: '×1M',
    tolerance: 0.25,
    tempco: 10,
  ),
  ResistorColorDef(
    name: 'Ungu',
    color: Color(0xFFA855F7),
    digit: 7,
    multiplier: 10000000,
    multiplierLabel: '×10M',
    tolerance: 0.1,
    tempco: 5,
  ),
  ResistorColorDef(
    name: 'Abu-abu',
    color: Color(0xFF6B7280),
    digit: 8,
    multiplier: 100000000,
    multiplierLabel: '×100M',
    tolerance: 0.05,
  ),
  ResistorColorDef(
    name: 'Putih',
    color: Color(0xFFFFFFFF),
    digit: 9,
    multiplier: 1000000000,
    multiplierLabel: '×1G',
    textColor: Colors.black,
  ),
  ResistorColorDef(
    name: 'Emas',
    color: Color(0xFFD4AF37),
    multiplier: 0.1,
    multiplierLabel: '×0.1',
    tolerance: 5,
    textColor: Colors.black,
  ),
  ResistorColorDef(
    name: 'Perak',
    color: Color(0xFFC0C0C0),
    multiplier: 0.01,
    multiplierLabel: '×0.01',
    tolerance: 10,
    textColor: Colors.black,
  ),
];

class ResistorCalculator extends StatefulWidget {
  const ResistorCalculator({super.key});

  @override
  State<ResistorCalculator> createState() => _ResistorCalculatorState();
}

class _ResistorCalculatorState extends State<ResistorCalculator> {
  int _bandCount = 4;
  late List<ResistorColorDef> _selectedColors;

  @override
  void initState() {
    super.initState();
    _resetDefaults();
  }

  void _resetDefaults() {
    if (_bandCount == 4) {
      _selectedColors = <ResistorColorDef>[
        kResistorColors[2], // Merah (2)
        kResistorColors[2], // Merah (2)
        kResistorColors[1], // Cokelat (×10)
        kResistorColors[10], // Emas (±5%)
      ];
    } else if (_bandCount == 5) {
      _selectedColors = <ResistorColorDef>[
        kResistorColors[2], // Merah (2)
        kResistorColors[2], // Merah (2)
        kResistorColors[0], // Hitam (0)
        kResistorColors[0], // Hitam (×1)
        kResistorColors[1], // Cokelat (±1%)
      ];
    } else {
      _selectedColors = <ResistorColorDef>[
        kResistorColors[2], // Merah (2)
        kResistorColors[2], // Merah (2)
        kResistorColors[0], // Hitam (0)
        kResistorColors[0], // Hitam (×1)
        kResistorColors[1], // Cokelat (±1%)
        kResistorColors[1], // Cokelat (100 ppm)
      ];
    }
  }

  BandType _getBandType(int i) {
    if (_bandCount == 4) return i <= 1 ? BandType.digit : (i == 2 ? BandType.multiplier : BandType.tolerance);
    if (_bandCount == 5) return i <= 2 ? BandType.digit : (i == 3 ? BandType.multiplier : BandType.tolerance);
    return i <= 2 ? BandType.digit : (i == 3 ? BandType.multiplier : (i == 4 ? BandType.tolerance : BandType.tempco));
  }

  String _getBandLabel(int i, BandType t) => switch (t) {
    BandType.digit => 'Gelang ${i + 1} (Digit)',
    BandType.multiplier => 'Gelang ${i + 1} (Pengali)',
    BandType.tolerance => 'Gelang ${i + 1} (Toleransi)',
    BandType.tempco => 'Gelang ${i + 1} (Koef. Suhu)',
  };

  List<ResistorColorDef> _getColors(BandType t) => switch (t) {
    BandType.digit => kResistorColors.where((c) => c.digit != null).take(10).toList(),
    BandType.multiplier => kResistorColors.where((c) => c.multiplier != null).toList(),
    BandType.tolerance => kResistorColors.where((c) => c.tolerance != null).toList(),
    BandType.tempco => kResistorColors.where((c) => c.tempco != null).toList(),
  };

  double _calcOhms() {
    if (_bandCount == 4) {
      return ((_selectedColors[0].digit ?? 0) * 10 + (_selectedColors[1].digit ?? 0)) * (_selectedColors[2].multiplier ?? 1);
    }
    return ((_selectedColors[0].digit ?? 0) * 100 + (_selectedColors[1].digit ?? 0) * 10 + (_selectedColors[2].digit ?? 0)) * (_selectedColors[3].multiplier ?? 1);
  }

  double? _calcTol() => _bandCount == 4 ? _selectedColors[3].tolerance : _selectedColors[4].tolerance;
  int? _calcTempco() => _bandCount == 6 ? _selectedColors[5].tempco : null;

  String _formatOhms(double ohms) {
    if (ohms >= 1e9) return '${(ohms / 1e9).toStringAsFixed(ohms % 1e9 == 0 ? 0 : 1)} GΩ';
    if (ohms >= 1e6) return '${(ohms / 1e6).toStringAsFixed(ohms % 1e6 == 0 ? 0 : 1)} MΩ';
    if (ohms >= 1e3) return '${(ohms / 1e3).toStringAsFixed(ohms % 1e3 == 0 ? 0 : 1)} kΩ';
    return '${ohms.toStringAsFixed(ohms.truncateToDouble() == ohms ? 0 : 2)} Ω';
  }

  void _pickColor(int i) {
    final BandType t = _getBandType(i);
    final List<ResistorColorDef> colors = _getColors(t);
    final ResistorColorDef current = _selectedColors[i];

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => _ColorPickerSheet(
        title: _getBandLabel(i, t),
        colors: colors,
        currentColor: current,
        onSelected: (c) {
          setState(() => _selectedColors[i] = c);
          Navigator.of(ctx).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          VoltCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Kalkulator Kode Warna Resistor', style: AppTypography.title),
                const SizedBox(height: AppSpacing.xs),
                const Text('Pilih jumlah gelang lalu ketuk gelang untuk mengubah warna.', style: AppTypography.bodyMuted),
                const SizedBox(height: AppSpacing.lg),
                const Text('Jumlah Gelang', style: AppTypography.label),
                const SizedBox(height: AppSpacing.sm),
                SegmentedButton<int>(
                  segments: const <ButtonSegment<int>>[
                    ButtonSegment<int>(value: 4, label: Text('4 Gelang')),
                    ButtonSegment<int>(value: 5, label: Text('5 Gelang')),
                    ButtonSegment<int>(value: 6, label: Text('6 Gelang')),
                  ],
                  selected: <int>{_bandCount},
                  onSelectionChanged: (Set<int> newSelection) {
                    setState(() {
                      _bandCount = newSelection.first;
                      _resetDefaults();
                    });
                  },
                ),
                const SizedBox(height: AppSpacing.xl),
                _buildResistorVisual(),
                const SizedBox(height: AppSpacing.xl),
                _buildResultCard(),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const VoltCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Cara Membaca Gelang', style: AppTypography.title),
                SizedBox(height: AppSpacing.xs),
                Text(
                  '• 4 Gelang: Digit 1, Digit 2, Pengali, Toleransi\n'
                  '• 5 Gelang: Digit 1, Digit 2, Digit 3, Pengali, Toleransi\n'
                  '• 6 Gelang: Digit 1, Digit 2, Digit 3, Pengali, Toleransi, Koef. Suhu\n\n'
                  'Contoh 220 Ω ±5%: Merah (2) - Merah (2) - Cokelat (×10) - Emas (±5%)',
                  style: AppTypography.body,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: const Color(0xFF334155)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Nilai Hambatan',
            style: AppTypography.overline.copyWith(color: const Color(0xFF64748B)),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            _formatOhms(_calcOhms()),
            style: AppTypography.display.copyWith(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.w800,
            ),
          ),
          if (_calcTol() != null) ...<Widget>[
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Toleransi: ±${_calcTol()!.toStringAsFixed(_calcTol()! % 1 == 0 ? 0 : 2)}%',
              style: AppTypography.body.copyWith(
                color: AppColors.accent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          if (_calcTempco() != null) ...<Widget>[
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Koefisien Suhu: ${_calcTempco()} ppm/K',
              style: AppTypography.body.copyWith(
                color: const Color(0xFF94A3B8),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildResistorVisual() {
    return Column(
      children: <Widget>[
        Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          decoration: BoxDecoration(
            color: const Color(0xFFD7C4A5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFB8A282), width: 3),
            boxShadow: AppShadows.card,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(_bandCount, (i) {
              final ResistorColorDef c = _selectedColors[i];
              return GestureDetector(
                onTap: () => _pickColor(i),
                child: Container(
                  width: 20,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: c.color,
                    border: Border.all(
                      color: c.color.computeLuminance() > 0.5
                          ? const Color(0xFF94A3B8)
                          : Colors.black26,
                      width: 1,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(_bandCount, (i) {
            final BandType type = _getBandType(i);
            final String label = switch (type) {
              BandType.digit => 'D${i + 1}',
              BandType.multiplier => 'Pengali',
              BandType.tolerance => 'Tol.',
              BandType.tempco => 'PPM',
            };
            return InkWell(
              onTap: () => _pickColor(i),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: Text(
                  label,
                  style: AppTypography.caption.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _ColorPickerSheet extends StatelessWidget {
  const _ColorPickerSheet({
    required this.title,
    required this.colors,
    required this.currentColor,
    required this.onSelected,
  });

  final String title;
  final List<ResistorColorDef> colors;
  final ResistorColorDef currentColor;
  final ValueChanged<ResistorColorDef> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.card)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(title, style: AppTypography.title),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: colors.map((c) {
                final bool isSelected = c.name == currentColor.name;
                return ActionChip(
                  avatar: CircleAvatar(
                    backgroundColor: c.color,
                    radius: 8,
                  ),
                  label: Text(
                    c.name,
                    style: AppTypography.label.copyWith(
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected ? AppColors.primary : AppColors.textPrimary,
                    ),
                  ),
                  backgroundColor:
                      isSelected ? AppColors.primaryLight : AppColors.background,
                  side: BorderSide(
                    color: isSelected ? AppColors.primary : AppColors.border,
                  ),
                  onPressed: () => onSelected(c),
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}

