import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:voltar/pages/auth/auth_form_widgets.dart';
import 'package:voltar/pages/auth/auth_validators.dart';
import 'package:voltar/services/auth_service.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/volt_card.dart';

/// Halaman Daftar Akun Baru (Register) EduVolt.
class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  String? _errorMessage;
  PasswordStrength _passwordStrength = PasswordStrength.none;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (_isLoading) return;

    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await ref.read(authServiceProvider).register(
            _nameController.text,
            _emailController.text,
            _passwordController.text,
            'siswa',
          );
      if (!mounted) return;
      // TODO(fase-guru): arahkan berdasarkan role
      context.go('/');
    } on AuthException catch (e) {
      if (!mounted) return;
      setState(() => _errorMessage = e.message);
    } catch (_) {
      if (!mounted) return;
      setState(
        () => _errorMessage =
            'Terjadi kesalahan saat mendaftar. Silakan coba lagi.',
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Color _strengthColor(PasswordStrength strength) => switch (strength) {
    PasswordStrength.none => AppColors.border,
    PasswordStrength.weak => AppColors.error,
    PasswordStrength.medium => AppColors.accent,
    PasswordStrength.strong => AppColors.success,
  };

  Widget _buildStrengthIndicator() {
    if (_passwordStrength == PasswordStrength.none) {
      return const SizedBox.shrink();
    }
    final Color color = _strengthColor(_passwordStrength);
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: Row(
        children: <Widget>[
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: LinearProgressIndicator(
                value: _passwordStrength.progress,
                backgroundColor: AppColors.border,
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 6,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Text(
            _passwordStrength.label,
            style: AppTypography.label.copyWith(color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard() {
    return VoltCard(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (_errorMessage != null) ...<Widget>[
              AuthErrorBanner(message: _errorMessage!),
              const SizedBox(height: AppSpacing.lg),
            ],
            AuthTextField(
              fieldKey: const Key('register_name_field'),
              label: 'Nama Lengkap',
              hintText: 'Masukkan nama lengkap Anda',
              controller: _nameController,
              focusNode: _nameFocus,
              prefixIcon: Icons.person_outline_rounded,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              autofillHints: const <String>[AutofillHints.name],
              enabled: !_isLoading,
              validator: AuthValidators.validateName,
            ),
            const SizedBox(height: AppSpacing.lg),
            AuthTextField(
              fieldKey: const Key('register_email_field'),
              label: 'Email',
              hintText: 'nama@sekolah.sch.id',
              controller: _emailController,
              focusNode: _emailFocus,
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const <String>[AutofillHints.email],
              enabled: !_isLoading,
              validator: AuthValidators.validateEmail,
            ),
            const SizedBox(height: AppSpacing.lg),
            AuthTextField(
              fieldKey: const Key('register_password_field'),
              label: 'Password',
              hintText: 'Minimal 6 karakter',
              controller: _passwordController,
              focusNode: _passwordFocus,
              prefixIcon: Icons.lock_outline_rounded,
              obscureText: _obscurePassword,
              textInputAction: TextInputAction.next,
              autofillHints: const <String>[AutofillHints.newPassword],
              enabled: !_isLoading,
              validator: AuthValidators.validatePassword,
              onChanged: (String val) {
                setState(() {
                  _passwordStrength =
                      AuthValidators.evaluatePasswordStrength(val);
                });
              },
              suffixIcon: PasswordVisibilityButton(
                obscureText: _obscurePassword,
                onPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
              ),
            ),
            _buildStrengthIndicator(),
            const SizedBox(height: AppSpacing.lg),
            AuthTextField(
              fieldKey: const Key('register_confirm_field'),
              label: 'Konfirmasi Password',
              hintText: 'Ulangi password Anda',
              controller: _confirmPasswordController,
              focusNode: _confirmPasswordFocus,
              prefixIcon: Icons.lock_reset_rounded,
              obscureText: _obscureConfirmPassword,
              textInputAction: TextInputAction.done,
              autofillHints: const <String>[AutofillHints.newPassword],
              enabled: !_isLoading,
              validator: (String? val) =>
                  AuthValidators.validateConfirmPassword(
                    val,
                    _passwordController.text,
                  ),
              onFieldSubmitted: (_) => _handleRegister(),
              suffixIcon: PasswordVisibilityButton(
                obscureText: _obscureConfirmPassword,
                onPressed: () {
                  setState(
                    () => _obscureConfirmPassword = !_obscureConfirmPassword,
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            AuthSubmitButton(
              buttonKey: const Key('register_submit_button'),
              label: 'Daftar',
              isLoading: _isLoading,
              onPressed: _handleRegister,
            ),
          ],
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.pagePadding,
              vertical: AppSpacing.xxl,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const AuthHeader(
                    title: 'Buat Akun EduVolt',
                    subtitle: 'Mulai petualangan elektronika dan raih koinmu!',
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  _buildFormCard(),
                  const SizedBox(height: AppSpacing.xl),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Sudah punya akun? ',
                        style: AppTypography.bodyMuted,
                      ),
                      TextButton(
                        onPressed: _isLoading
                            ? null
                            : () => context.go('/login'),
                        child: const Text('Masuk'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
