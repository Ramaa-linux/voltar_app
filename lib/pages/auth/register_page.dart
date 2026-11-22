import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:voltar/l10n/app_localizations.dart';
import 'package:voltar/pages/auth/auth_form_widgets.dart';
import 'package:voltar/pages/auth/auth_validators.dart';
import 'package:voltar/services/auth_service.dart';
import 'package:voltar/theme/app_borders.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/utils/localization_helper.dart';
import 'package:voltar/widgets/volt_card.dart';

/// Halaman Daftar Akun Baru (Register) EduVolt — Fase 25A.
class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _teacherCodeController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final FocusNode _teacherCodeFocus = FocusNode();

  late final AnimationController _animController;
  late final Animation<double> _expandAnimation;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  String? _errorMessage;
  PasswordStrength _passwordStrength = PasswordStrength.none;
  String _selectedRole = 'siswa';

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
    _expandAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _teacherCodeController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    _teacherCodeFocus.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _onRoleChanged(String role) {
    if (_selectedRole == role) return;
    setState(() {
      _selectedRole = role;
      if (role == 'guru') {
        _animController.forward();
      } else {
        _animController.reverse();
        _teacherCodeController.clear();
        _formKey.currentState?.validate();
      }
    });
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
      await ref
          .read(authServiceProvider)
          .register(
            _nameController.text,
            _emailController.text,
            _passwordController.text,
            _selectedRole,
            teacherCode: _selectedRole == 'guru'
                ? _teacherCodeController.text.trim().toUpperCase()
                : null,
          );
      if (!mounted) return;
      final String email = _emailController.text.trim().toLowerCase();
      context.go(
        Uri(
          path: '/verification-pending',
          queryParameters: {'email': email},
        ).toString(),
      );
    } on AuthException catch (e) {
      if (!mounted) return;
      final String msg = context.t(e.message);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: AppColors.error,
          action: e.code == 'email-already-in-use'
              ? SnackBarAction(
                  label: context.t('loginLink'),
                  textColor: Colors.white,
                  onPressed: () => context.go('/login'),
                )
              : null,
        ),
      );
      setState(() => _errorMessage = msg);
      if (e.code == 'teacher-code-not-found' ||
          e.code == 'teacher-code-invalid' ||
          e.code == 'teacher-code-empty') {
        _teacherCodeFocus.requestFocus();
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _errorMessage = friendlyAuthError(e));
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
            context.t(_passwordStrength.label),
            style: AppTypography.label.copyWith(color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard() {
    final l10n = AppLocalizations.of(context)!;
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
              AuthErrorBanner(message: context.t(_errorMessage!)),
              const SizedBox(height: AppSpacing.lg),
            ],
            AuthTextField(
              fieldKey: const Key('register_name_field'),
              label: l10n.registerNameLabel,
              hintText: l10n.registerNameHint,
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
              label: l10n.emailLabel,
              hintText: l10n.registerEmailHint,
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
              label: l10n.passwordLabel,
              hintText: l10n.registerPasswordHint,
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
                  _passwordStrength = AuthValidators.evaluatePasswordStrength(
                    val,
                  );
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
              label: l10n.registerConfirmPasswordLabel,
              hintText: l10n.registerConfirmPasswordHint,
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
            const SizedBox(height: AppSpacing.lg),
            _buildRoleSelector(),
            _buildTeacherCodeField(),
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

  Widget _buildRoleSelector() {
    final l10n = AppLocalizations.of(context)!;
    final bool isSiswa = _selectedRole == 'siswa';
    final bool disableAnim = MediaQuery.disableAnimationsOf(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Daftar Sebagai',
          style: AppTypography.label.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          padding: const EdgeInsets.all(4),
          child: Stack(
            children: <Widget>[
              // ponytail: 2-tab sliding pill via AnimatedAlign. Upgrade to LayoutBuilder if tabs > 2.
              Positioned.fill(
                child: AnimatedAlign(
                  alignment: isSiswa
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  duration: disableAnim
                      ? Duration.zero
                      : const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  child: FractionallySizedBox(
                    widthFactor: 0.5,
                    heightFactor: 1.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.25),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: _RoleSegment(
                        optionKey: const Key('role_option_siswa'),
                        label: l10n.registerRoleStudent,
                        icon: Icons.school_rounded,
                        isSelected: isSiswa,
                        onTap: () => _onRoleChanged('siswa'),
                      ),
                    ),
                    Expanded(
                      child: _RoleSegment(
                        optionKey: const Key('role_option_guru'),
                        label: l10n.registerRoleTeacher,
                        icon: Icons.badge_rounded,
                        isSelected: !isSiswa,
                        onTap: () => _onRoleChanged('guru'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTeacherCodeField() {
    final l10n = AppLocalizations.of(context)!;
    if (_selectedRole != 'guru') {
      return const SizedBox.shrink();
    }
    return SizeTransition(
      sizeFactor: _expandAnimation,
      alignment: Alignment.topCenter,
      child: FadeTransition(
        opacity: _expandAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: AppSpacing.lg),
            AuthTextField(
              fieldKey: const Key('register_teacher_code_field'),
              label: l10n.registerTeacherCodeLabel,
              hintText: l10n.registerTeacherCodeHint,
              controller: _teacherCodeController,
              focusNode: _teacherCodeFocus,
              prefixIcon: Icons.verified_user_rounded,
              textInputAction: TextInputAction.done,
              autofillHints: const <String>[],
              enabled: !_isLoading,
              validator: (String? val) =>
                  AuthValidators.validateTeacherCode(val, isGuru: true),
              onFieldSubmitted: (_) => _handleRegister(),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.registerTeacherCodeDescription,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                  AuthHeader(
                    title: l10n.appTitle,
                    subtitle: l10n.registerTitle,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  _buildFormCard(),
                  const SizedBox(height: AppSpacing.xl),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      Text(
                        l10n.hasAccount,
                        style: AppTypography.bodyMuted,
                      ),
                      TextButton(
                        onPressed: _isLoading
                            ? null
                            : () => context.go('/login'),
                        child: Text(l10n.loginLink),
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

/// Widget privat untuk opsi role Siswa/Guru di dalam segmented control.
class _RoleSegment extends StatelessWidget {
  const _RoleSegment({
    this.optionKey,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final Key? optionKey;
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color fgColor = isSelected ? Colors.white : AppColors.textSecondary;

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: Material(
        key: optionKey,
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(icon, size: 20, color: fgColor),
                const SizedBox(width: AppSpacing.sm),
                Flexible(
                  child: Text(
                    label,
                    style: AppTypography.button.copyWith(
                      color: fgColor,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
