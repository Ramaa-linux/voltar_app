import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:voltar/services/auth_service.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/utils/localization_helper.dart';
import 'package:voltar/widgets/volt_button.dart';
import 'package:voltar/widgets/volt_card.dart';

/// Halaman Menunggu Verifikasi Email (Fase 25A Tugas 3).
class VerificationPendingPage extends ConsumerStatefulWidget {
  const VerificationPendingPage({super.key, this.email, this.nowSeam});

  final String? email;
  final DateTime Function()? nowSeam;

  @override
  ConsumerState<VerificationPendingPage> createState() =>
      _VerificationPendingPageState();
}

class _VerificationPendingPageState
    extends ConsumerState<VerificationPendingPage>
    with WidgetsBindingObserver {
  static const int _initialCooldownSeconds = 120;

  DateTime? _resendAvailableAt;
  Timer? _countdownTimer;
  Timer? _pollTimer;
  int _remainingSeconds = _initialCooldownSeconds;

  bool _isSending = false;
  bool _isChecking = false;
  bool _isLoggingOut = false;

  DateTime _now() =>
      widget.nowSeam != null ? widget.nowSeam!() : DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startCooldown(_initialCooldownSeconds);
    _startPolling();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _countdownTimer?.cancel();
    _pollTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkVerificationSilently();
    }
  }

  void _startCooldown(int seconds) {
    _resendAvailableAt = _now().add(Duration(seconds: seconds));
    _remainingSeconds = seconds;
    _countdownTimer?.cancel();
    if (seconds <= 0) return;

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      final int remaining = _resendAvailableAt != null
          ? _resendAvailableAt!.difference(_now()).inSeconds
          : 0;

      if (remaining <= 0) {
        timer.cancel();
        setState(() => _remainingSeconds = 0);
      } else {
        setState(() => _remainingSeconds = remaining);
      }
    });
  }

  void _startPolling() {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      _checkVerificationSilently();
    });
  }

  Future<void> _checkVerificationSilently() async {
    if (!mounted || _isChecking) return;
    try {
      await ref.read(authServiceProvider).reloadAndCheckVerified();
    } catch (_) {}
  }

  String _resolveTargetEmail(AuthService authService) {
    final String? userEmail = authService.currentUser?.email;
    if (userEmail != null && userEmail.trim().isNotEmpty) {
      return userEmail.trim();
    }
    if (widget.email != null && widget.email!.trim().isNotEmpty) {
      return widget.email!.trim();
    }
    return '';
  }

  Future<void> _handleResend() async {
    if (_remainingSeconds > 0 || _isSending) return;
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    setState(() => _isSending = true);

    try {
      await ref.read(authServiceProvider).sendVerificationEmail();
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text(context.t('verificationPendingResent')),
          backgroundColor: AppColors.success,
        ),
      );
      _startCooldown(_initialCooldownSeconds);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text(context.t(friendlyAuthError(e))),
          backgroundColor: AppColors.error,
        ),
      );
      if (e.code == 'too-many-requests') {
        _startCooldown(_initialCooldownSeconds);
      }
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text(context.t(friendlyAuthError(e))),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  Future<void> _handleManualCheck() async {
    if (_isChecking) return;
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    setState(() => _isChecking = true);

    try {
      final bool isVerified = await ref
          .read(authServiceProvider)
          .reloadAndCheckVerified();
      if (!mounted) return;
      if (!isVerified) {
        messenger.showSnackBar(
          SnackBar(
            content: Text(
              context.t('verificationPendingNotVerified'),
            ),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text(context.t(friendlyAuthError(e))),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _isChecking = false);
    }
  }

  Future<void> _handleBackToLogin() async {
    if (_isLoggingOut) return;
    final GoRouter? router = GoRouter.maybeOf(context);
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    setState(() => _isLoggingOut = true);

    try {
      await ref.read(authServiceProvider).logout();
      router?.go('/login');
    } catch (e) {
      if (mounted) {
        setState(() => _isLoggingOut = false);
        messenger.showSnackBar(
          SnackBar(
            content: Text(context.t(friendlyAuthError(e))),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Widget _buildEmailDescription(BuildContext context, String targetEmail) {
    if (targetEmail.isEmpty) {
      return Text(
        context.t('verificationPendingDescGeneric'),
        style: AppTypography.bodyMuted,
        textAlign: TextAlign.center,
      );
    }
    return Text.rich(
      TextSpan(
        style: AppTypography.body.copyWith(color: AppColors.textSecondary),
        children: <TextSpan>[
          TextSpan(
            text: context.t('verificationPendingDescEmailPrefix'),
            style: AppTypography.body.copyWith(color: AppColors.textSecondary),
          ),
          TextSpan(
            text: targetEmail,
            style: AppTypography.body.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: context.t('verificationPendingDescEmailSuffix'),
            style: AppTypography.body.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    final AuthService authService = ref.watch(authServiceProvider);
    final String targetEmail = _resolveTargetEmail(authService);
    final bool isCooldownActive = _remainingSeconds > 0;
    final String resendLabel = isCooldownActive
        ? context.t('verificationPendingResendCooldown', args: [_remainingSeconds])
        : context.t('verificationPendingResendLabel');

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
              child: VoltCard(
                padding: const EdgeInsets.all(AppSpacing.xxl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Center(
                      child: Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            width: 2,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.mail_outline_rounded,
                          size: 52,
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Text(
                      context.t('verificationPendingHeader'),
                      style: AppTypography.heading,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildEmailDescription(context, targetEmail),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      context.t('verificationPendingSpamHint'),
                      style: AppTypography.caption,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    VoltButton(
                      key: const Key('resend_verification_button'),
                      label: _isSending ? context.t('verificationPendingResending') : resendLabel,
                      fullWidth: true,
                      onPressed: (isCooldownActive || _isSending)
                          ? null
                          : _handleResend,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    OutlinedButton(
                      key: const Key('check_verification_button'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        foregroundColor: AppColors.primaryDark,
                        side: const BorderSide(color: AppColors.border),
                      ),
                      onPressed: _isChecking ? null : _handleManualCheck,
                      child: _isChecking
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(
                              context.t('verificationPendingCheckButton'),
                              style: AppTypography.button,
                            ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Center(
                      child: TextButton(
                        key: const Key('back_to_login_button'),
                        onPressed: _isLoggingOut ? null : _handleBackToLogin,
                        child: Text(
                          _isLoggingOut ? context.t('verificationPendingLoggingOut') : context.t('verificationPendingBackToLogin'),
                          style: AppTypography.button.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
