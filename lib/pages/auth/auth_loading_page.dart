import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voltar/services/auth_service.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/utils/localization_helper.dart';
import 'package:voltar/widgets/volt_button.dart';
import 'package:voltar/widgets/volt_card.dart';

/// Halaman transisi saat role pengguna dimuat asinkron atau terjadi error pemuatan role.
class AuthLoadingPage extends ConsumerStatefulWidget {
  const AuthLoadingPage({super.key});

  @override
  ConsumerState<AuthLoadingPage> createState() => _AuthLoadingPageState();
}

class _AuthLoadingPageState extends ConsumerState<AuthLoadingPage> {
  bool _isRetrying = false;
  bool _isLoggingOut = false;

  Future<void> _handleRetry() async {
    if (_isRetrying) return;
    setState(() => _isRetrying = true);
    try {
      await ref.read(authServiceProvider).reloadAndCheckVerified();
    } catch (_) {
      // Error akan tercermin di snapshot.roleError
    } finally {
      if (mounted) {
        setState(() => _isRetrying = false);
      }
    }
  }

  Future<void> _handleLogout() async {
    if (_isLoggingOut) return;
    setState(() => _isLoggingOut = true);
    try {
      await ref.read(authServiceProvider).logout();
    } catch (_) {
      // Best-effort logout
    } finally {
      if (mounted) {
        setState(() => _isLoggingOut = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthService authService = ref.watch(authServiceProvider);
    final AuthSnapshot snapshot = authService.snapshot;
    final bool isError = snapshot.status == AuthStatus.roleError;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.pagePadding,
              vertical: AppSpacing.xl,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: isError
                  ? _buildErrorContent(snapshot.errorMessage)
                  : _buildLoadingContent(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 48,
          height: 48,
          child: CircularProgressIndicator(
            strokeWidth: 3.5,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: AppSpacing.xl),
        Text(
          context.t('authLoadingPreparing'),
          style: AppTypography.heading,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppSpacing.sm),
        Text(
          context.t('authLoadingWaitMessage'),
          style: AppTypography.bodyMuted,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildErrorContent(String? errorMessage) {
    return VoltCard(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: AppColors.errorLight,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.warning_amber_rounded,
              color: AppColors.error,
              size: 32,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            context.t('authLoadingFailedTitle'),
            style: AppTypography.heading,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            errorMessage ?? context.t('authLoadingFailedMessage'),
            style: AppTypography.bodyMuted,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),
          VoltButton(
            label: _isRetrying ? context.t('authLoadingRetrying') : context.t('authLoadingRetry'),
            fullWidth: true,
            onPressed: (_isRetrying || _isLoggingOut) ? null : _handleRetry,
          ),
          const SizedBox(height: AppSpacing.md),
          TextButton(
            onPressed: (_isRetrying || _isLoggingOut) ? null : _handleLogout,
            child: Text(
              _isLoggingOut ? context.t('authLoadingLoggingOut') : context.t('authLoadingLogout'),
              style: AppTypography.button.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
