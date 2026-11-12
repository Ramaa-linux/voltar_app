import 'package:flutter/material.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/volt_button.dart';

/// Header branding EduVolt untuk layar Login & Register.
class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(AppRadius.button),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.2),
              width: AppBorders.thin,
            ),
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.bolt_rounded,
            size: 36,
            color: AppColors.primaryDark,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          title,
          style: AppTypography.heading,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          subtitle,
          style: AppTypography.bodyMuted,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// Banner error inline di atas form autentikasi.
class AuthErrorBanner extends StatelessWidget {
  const AuthErrorBanner({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.errorLight,
        borderRadius: BorderRadius.circular(AppRadius.input),
        border: Border.all(
          color: AppColors.error.withValues(alpha: 0.35),
          width: AppBorders.thin,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(
            Icons.error_outline_rounded,
            color: AppColors.error,
            size: 20,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: AppTypography.body.copyWith(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

/// Input teks berlabel sesuai Design System EduVolt.
class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.prefixIcon,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.autofillHints,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.enabled = true,
    this.fieldKey,
  });

  final String label;
  final String hintText;
  final TextEditingController controller;
  final IconData prefixIcon;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final Iterable<String>? autofillHints;
  final bool obscureText;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final bool enabled;
  final Key? fieldKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          label,
          style: AppTypography.label.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          key: fieldKey,
          controller: controller,
          focusNode: focusNode,
          enabled: enabled,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          textCapitalization: textCapitalization,
          autofillHints: autofillHints,
          obscureText: obscureText,
          style: AppTypography.body,
          validator: validator,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(
              prefixIcon,
              size: 20,
              color: AppColors.textSecondary,
            ),
            suffixIcon: suffixIcon,
            errorMaxLines: 2,
          ),
        ),
      ],
    );
  }
}

/// Tombol mata visibilitas password dengan aksesibilitas penuh.
class PasswordVisibilityButton extends StatelessWidget {
  const PasswordVisibilityButton({
    super.key,
    required this.obscureText,
    required this.onPressed,
  });

  final bool obscureText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final String label = obscureText
        ? 'Tampilkan password'
        : 'Sembunyikan password';
    return Semantics(
      button: true,
      label: label,
      child: IconButton(
        tooltip: label,
        onPressed: onPressed,
        icon: Icon(
          obscureText
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          size: 20,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}

/// Tombol submit berbasis [VoltButton] dengan indikator loading non-shift.
class AuthSubmitButton extends StatelessWidget {
  const AuthSubmitButton({
    super.key,
    required this.label,
    required this.isLoading,
    required this.onPressed,
    this.buttonKey,
  });

  final String label;
  final bool isLoading;
  final VoidCallback onPressed;
  final Key? buttonKey;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        VoltButton(
          key: buttonKey,
          label: isLoading ? 'Memproses...' : label,
          fullWidth: true,
          onPressed: isLoading ? null : onPressed,
        ),
        if (isLoading)
          const Positioned(
            right: AppSpacing.lg,
            child: SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2.2,
                color: AppColors.primaryDark,
              ),
            ),
          ),
      ],
    );
  }
}

