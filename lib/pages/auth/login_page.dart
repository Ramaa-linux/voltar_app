import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:voltar/pages/auth/auth_form_widgets.dart';
import 'package:voltar/pages/auth/auth_validators.dart';
import 'package:voltar/services/auth_service.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/volt_card.dart';

/// Halaman Masuk (Login) EduVolt.
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
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
      await ref.read(authServiceProvider).login(
            _emailController.text,
            _passwordController.text,
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
        () => _errorMessage = 'Terjadi kesalahan saat masuk. Silakan coba lagi.',
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
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
                    title: 'EduVolt',
                    subtitle: 'Belajar listrik jadi seru ⚡',
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  VoltCard(
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
                            fieldKey: const Key('login_email_field'),
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
                            fieldKey: const Key('login_password_field'),
                            label: 'Password',
                            hintText: 'Masukkan password Anda',
                            controller: _passwordController,
                            focusNode: _passwordFocus,
                            prefixIcon: Icons.lock_outline_rounded,
                            obscureText: _obscurePassword,
                            textInputAction: TextInputAction.done,
                            autofillHints: const <String>[
                              AutofillHints.password,
                            ],
                            enabled: !_isLoading,
                            validator: AuthValidators.validatePassword,
                            onFieldSubmitted: (_) => _handleLogin(),
                            suffixIcon: PasswordVisibilityButton(
                              obscureText: _obscurePassword,
                              onPressed: () {
                                setState(
                                  () => _obscurePassword = !_obscurePassword,
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xl),
                          AuthSubmitButton(
                            buttonKey: const Key('login_submit_button'),
                            label: 'Masuk',
                            isLoading: _isLoading,
                            onPressed: _handleLogin,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Belum punya akun? ',
                        style: AppTypography.bodyMuted,
                      ),
                      TextButton(
                        onPressed: _isLoading
                            ? null
                            : () => context.go('/register'),
                        child: const Text('Daftar'),
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
