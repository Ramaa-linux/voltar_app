import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voltar/pages/alat/ohm_logic.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/volt_button.dart';
import 'package:voltar/widgets/volt_card.dart';

/// Menampilkan Kalkulator Hukum Ohm sebagai modal bottom sheet.
Future<void> showOhmCalculator(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext ctx) => const OhmCalculatorSheet(),
  );
}

/// Formatter angka desimal non-negatif (menerima digit serta maksimal satu '.' atau ',').
class SingleDecimalInputFormatter extends TextInputFormatter {
  const SingleDecimalInputFormatter();

  static final RegExp _validPattern = RegExp(r'^\d*([.,]\d*)?$');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty || _validPattern.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
}

/// Widget utama Kalkulator Hukum Ohm di dalam bottom sheet.
class OhmCalculatorSheet extends StatefulWidget {
  const OhmCalculatorSheet({super.key});

  @override
  State<OhmCalculatorSheet> createState() => _OhmCalculatorSheetState();
}

class _OhmCalculatorSheetState extends State<OhmCalculatorSheet> {
  final Map<OhmVariable, TextEditingController> _controllers = {
    OhmVariable.voltage: TextEditingController(),
    OhmVariable.current: TextEditingController(),
    OhmVariable.resistance: TextEditingController(),
  };

  final Map<OhmVariable, FocusNode> _focusNodes = {
    OhmVariable.voltage: FocusNode(),
    OhmVariable.current: FocusNode(),
    OhmVariable.resistance: FocusNode(),
  };

  final List<OhmVariable> _userEditedOrder = <OhmVariable>[];

  OhmVariable? _autoCalculatedVar;
  String? _errorMessage;
  OhmVariable? _errorVariable;
  bool _isUpdatingProgrammatically = false;

  @override
  void dispose() {
    for (final TextEditingController c in _controllers.values) {
      c.dispose();
    }
    for (final FocusNode f in _focusNodes.values) {
      f.dispose();
    }
    super.dispose();
  }

  void _onUserChanged(OhmVariable editedVar, String text) {
    if (_isUpdatingProgrammatically) return;

    final double? val = OhmCalculator.parseInput(text);

    if (_autoCalculatedVar == editedVar) {
      _autoCalculatedVar = null;
    }

    _userEditedOrder.remove(editedVar);
    if (val != null) {
      _userEditedOrder.add(editedVar);
      if (_userEditedOrder.length > 2) {
        _userEditedOrder.removeAt(0);
      }
    }

    _recompute();
  }

  void _recompute() {
    _isUpdatingProgrammatically = true;
    try {
      _userEditedOrder.removeWhere(
        (OhmVariable v) =>
            OhmCalculator.parseInput(_controllers[v]!.text) == null,
      );

      if (_userEditedOrder.length < 2) {
        if (_autoCalculatedVar != null &&
            !_userEditedOrder.contains(_autoCalculatedVar)) {
          _controllers[_autoCalculatedVar!]!.clear();
        }
        setState(() {
          _autoCalculatedVar = null;
          _errorMessage = null;
          _errorVariable = null;
        });
        return;
      }

      final OhmVariable target = OhmVariable.values.firstWhere(
        (OhmVariable v) => !_userEditedOrder.contains(v),
      );

      final double? vVal = _userEditedOrder.contains(OhmVariable.voltage)
          ? OhmCalculator.parseInput(_controllers[OhmVariable.voltage]!.text)
          : null;
      final double? iVal = _userEditedOrder.contains(OhmVariable.current)
          ? OhmCalculator.parseInput(_controllers[OhmVariable.current]!.text)
          : null;
      final double? rVal = _userEditedOrder.contains(OhmVariable.resistance)
          ? OhmCalculator.parseInput(_controllers[OhmVariable.resistance]!.text)
          : null;

      final OhmCalculationResult result = OhmCalculator.calculate(
        voltage: vVal,
        current: iVal,
        resistance: rVal,
        editHistory: _userEditedOrder,
      );

      if (result.hasError) {
        _controllers[target]!.clear();
        OhmVariable? zeroVar;
        if (target == OhmVariable.current && rVal == 0) {
          zeroVar = OhmVariable.resistance;
        } else if (target == OhmVariable.resistance && iVal == 0) {
          zeroVar = OhmVariable.current;
        } else {
          zeroVar = target;
        }
        setState(() {
          _autoCalculatedVar = null;
          _errorMessage = result.errorMessage;
          _errorVariable = zeroVar;
        });
      } else if (result.hasResult && result.formattedValue != null) {
        final TextEditingController targetCtrl = _controllers[target]!;
        targetCtrl.value = TextEditingValue(
          text: result.formattedValue!,
          selection: TextSelection.collapsed(
            offset: result.formattedValue!.length,
          ),
        );
        setState(() {
          _autoCalculatedVar = target;
          _errorMessage = null;
          _errorVariable = null;
        });
      }
    } finally {
      _isUpdatingProgrammatically = false;
    }
  }

  void _resetAll() {
    _isUpdatingProgrammatically = true;
    try {
      for (final TextEditingController c in _controllers.values) {
        c.clear();
      }
      _userEditedOrder.clear();
      setState(() {
        _autoCalculatedVar = null;
        _errorMessage = null;
        _errorVariable = null;
      });
    } finally {
      _isUpdatingProgrammatically = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.only(bottom: bottomInset),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.card),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: AppSpacing.sm),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.borderStrong,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.pagePadding,
                AppSpacing.md,
                AppSpacing.pagePadding,
                AppSpacing.sm,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Kalkulator Hukum Ohm',
                          style: AppTypography.title,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'Isi 2 nilai, nilai ketiga dihitung otomatis',
                          style: AppTypography.bodyMuted,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                    tooltip: 'Tutup',
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.pagePadding,
                  AppSpacing.sm,
                  AppSpacing.pagePadding,
                  AppSpacing.xl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const VoltCard(
                      padding: EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Rumus Dasar', style: AppTypography.label),
                          SizedBox(height: AppSpacing.xs),
                          Wrap(
                            spacing: AppSpacing.sm,
                            runSpacing: AppSpacing.xs,
                            children: <Widget>[
                              _FormulaBadge(text: 'V = I × R'),
                              _FormulaBadge(text: 'I = V / R'),
                              _FormulaBadge(text: 'R = V / I'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    ...OhmVariable.values.map((OhmVariable v) {
                      final bool isAuto = _autoCalculatedVar == v;
                      final String? fieldError = _errorVariable == v
                          ? _errorMessage
                          : null;
                      return _OhmInputField(
                        variable: v,
                        controller: _controllers[v]!,
                        focusNode: _focusNodes[v]!,
                        isAutoCalculated: isAuto,
                        errorMessage: fieldError,
                        onChanged: (String text) => _onUserChanged(v, text),
                      );
                    }),
                    const SizedBox(height: AppSpacing.md),
                    VoltButton(
                      label: 'Reset',
                      variant: VoltButtonVariant.secondary,
                      fullWidth: true,
                      onPressed: _resetAll,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormulaBadge extends StatelessWidget {
  const _FormulaBadge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(AppRadius.chip),
      ),
      child: Text(
        text,
        style: AppTypography.label.copyWith(
          color: AppColors.primaryDark,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _OhmInputField extends StatelessWidget {
  const _OhmInputField({
    required this.variable,
    required this.controller,
    required this.focusNode,
    required this.isAutoCalculated,
    required this.errorMessage,
    required this.onChanged,
  });

  final OhmVariable variable;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isAutoCalculated;
  final String? errorMessage;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final bool hasError = errorMessage != null;
    final Color borderColor = hasError
        ? AppColors.error
        : (isAutoCalculated ? AppColors.primary : AppColors.border);
    final Color bgColor = isAutoCalculated
        ? AppColors.primaryLight
        : AppColors.background;

    return Semantics(
      label: '${variable.label}: ${variable.unit}',
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  variable.label,
                  style: AppTypography.label.copyWith(
                    fontWeight: FontWeight.w600,
                    color: hasError ? AppColors.error : AppColors.textPrimary,
                  ),
                ),
                if (isAutoCalculated)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xs + 2,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(AppRadius.chip),
                    ),
                    child: Text(
                      'Hasil otomatis',
                      style: AppTypography.overline.copyWith(
                        color: AppColors.textOnPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            TextField(
              controller: controller,
              focusNode: focusNode,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: const <TextInputFormatter>[
                SingleDecimalInputFormatter(),
              ],
              onChanged: onChanged,
              style: AppTypography.body.copyWith(
                fontWeight: isAutoCalculated
                    ? FontWeight.w700
                    : FontWeight.w400,
                color: isAutoCalculated
                    ? AppColors.primaryDark
                    : AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: '0',
                hintStyle: AppTypography.body.copyWith(
                  color: AppColors.textTertiary,
                ),
                suffixText: variable.unit,
                suffixStyle: AppTypography.caption.copyWith(
                  color: isAutoCalculated
                      ? AppColors.primaryDark
                      : AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
                filled: true,
                fillColor: bgColor,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.md,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.input),
                  borderSide: BorderSide(
                    color: borderColor,
                    width: isAutoCalculated
                        ? AppBorders.focus
                        : AppBorders.thin,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.input),
                  borderSide: BorderSide(
                    color: hasError ? AppColors.error : AppColors.primary,
                    width: AppBorders.focus,
                  ),
                ),
              ),
            ),
            if (hasError) ...<Widget>[
              const SizedBox(height: AppSpacing.xs),
              Text(
                errorMessage!,
                style: AppTypography.caption.copyWith(
                  color: AppColors.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
