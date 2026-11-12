import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voltar/pages/auth/auth_form_widgets.dart';
import 'package:voltar/pages/auth/auth_validators.dart';
import 'package:voltar/pages/profil/profil_page.dart';
import 'package:voltar/services/auth_service.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/utils/volt_feedback.dart';
import 'package:voltar/widgets/app_icon.dart';
import 'package:voltar/widgets/volt_button.dart';
import 'package:voltar/widgets/volt_card.dart';

String? _safePhotoUrl(dynamic user) {
  if (user == null) return null;
  try {
    return user.photoURL?.toString().trim();
  } catch (_) {
    return null;
  }
}

/// Halaman Edit Profil (Fase 22A & 22B).
class EditProfilPage extends ConsumerStatefulWidget {
  const EditProfilPage({super.key, this.imagePicker});

  final ImagePicker? imagePicker;

  @override
  ConsumerState<EditProfilPage> createState() => _EditProfilPageState();
}

class _EditProfilPageState extends ConsumerState<EditProfilPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  final FocusNode _nameFocus = FocusNode();

  bool _isLoading = false;
  bool _isUploadingPhoto = false;
  String? _errorMessage;
  String? _photoUrl;

  @override
  void initState() {
    super.initState();
    final AuthService auth = ref.read(authServiceProvider);
    final Map<String, dynamic>? profile =
        ref.read(userProfileProvider).value;
    final dynamic user = auth.currentUser;

    final String initialName =
        (profile?['name'] as String?)?.trim().isNotEmpty == true
            ? (profile!['name'] as String).trim()
            : (user?.displayName?.toString().trim().isNotEmpty == true
                  ? user!.displayName!.toString().trim()
                  : 'Budi Santoso');
    final String initialEmail =
        (profile?['email'] as String?)?.trim().isNotEmpty == true
            ? (profile!['email'] as String).trim()
            : (user?.email?.toString().trim().isNotEmpty == true
                  ? user!.email!.toString().trim()
                  : 'budi.santoso@sekolah.sch.id');

    _photoUrl = (profile?['photoUrl'] as String?)?.trim().isNotEmpty == true
        ? (profile!['photoUrl'] as String).trim()
        : _safePhotoUrl(user);

    _nameController = TextEditingController(text: initialName);
    _emailController = TextEditingController(text: initialEmail);
    _nameController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _nameFocus.dispose();
    super.dispose();
  }

  Future<void> _handlePickPhoto() async {
    if (_isLoading || _isUploadingPhoto) return;

    final ImagePicker picker = widget.imagePicker ?? ImagePicker();
    try {
      final XFile? file = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );
      if (file == null) return;

      setState(() {
        _isUploadingPhoto = true;
        _errorMessage = null;
      });

      final Uint8List bytes = await file.readAsBytes();
      final String downloadUrl = await ref
          .read(authServiceProvider)
          .uploadProfilePicture(bytes);

      if (!mounted) return;
      setState(() {
        _photoUrl = downloadUrl;
      });
      showVoltSnackBar(context, 'Foto profil berhasil diperbarui');
    } on AuthException catch (e) {
      if (!mounted) return;
      setState(() => _errorMessage = e.message);
    } catch (_) {
      if (!mounted) return;
      setState(
        () => _errorMessage =
            'Gagal memilih atau mengunggah foto profil. Silakan coba lagi.',
      );
    } finally {
      if (mounted) {
        setState(() => _isUploadingPhoto = false);
      }
    }
  }

  Future<void> _handleSave() async {
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
          .updateProfile(name: _nameController.text.trim());
      if (!mounted) return;
      context.pop();
      showVoltSnackBar(context, 'Profil berhasil diperbarui');
    } on AuthException catch (e) {
      if (!mounted) return;
      setState(() => _errorMessage = e.message);
    } catch (_) {
      if (!mounted) return;
      setState(
        () => _errorMessage =
            'Terjadi kesalahan saat menyimpan profil. Silakan coba lagi.',
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(userProfileProvider, (_, AsyncValue<Map<String, dynamic>?> next) {
      final Map<String, dynamic>? data = next.value;
      if (data != null) {
        final String? firestoreName = data['name'] as String?;
        final String? firestoreEmail = data['email'] as String?;
        final String? firestorePhoto = data['photoUrl'] as String?;
        if (firestoreName != null && _nameController.text.isEmpty) {
          _nameController.text = firestoreName;
        }
        if (firestoreEmail != null && _emailController.text.isEmpty) {
          _emailController.text = firestoreEmail;
        }
        if (firestorePhoto != null &&
            firestorePhoto.isNotEmpty &&
            (_photoUrl == null || _photoUrl!.isEmpty)) {
          setState(() => _photoUrl = firestorePhoto);
        }
      }
    });

    final bool hasPhoto = _photoUrl != null && _photoUrl!.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const AppIcon.arrowLeft(
            size: AppIconSize.md,
            color: AppColors.textPrimary,
          ),
          onPressed: () => context.pop(),
          tooltip: 'Kembali',
        ),
        title: Text('Edit Profil', style: AppTypography.title),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.pagePadding,
              vertical: AppSpacing.xl,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: VoltCard(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if (_errorMessage != null) ...<Widget>[
                        AuthErrorBanner(message: _errorMessage!),
                        const SizedBox(height: AppSpacing.lg),
                      ],
                      Center(
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: <Widget>[
                            CircleAvatar(
                              key: const Key('edit_avatar_circle'),
                              radius: 52,
                              backgroundColor: AppColors.primaryLight,
                              backgroundImage:
                                  hasPhoto ? NetworkImage(_photoUrl!) : null,
                              child: _isUploadingPhoto
                                  ? const SizedBox(
                                      width: 32,
                                      height: 32,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                        color: AppColors.primaryDark,
                                      ),
                                    )
                                  : (hasPhoto
                                      ? null
                                      : Text(
                                          initialsFromName(_nameController.text),
                                          style: AppTypography.display.copyWith(
                                            color: AppColors.primaryDark,
                                          ),
                                        )),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Material(
                                color: AppColors.primary,
                                shape: const CircleBorder(),
                                elevation: 2,
                                child: InkWell(
                                  key: const Key('edit_avatar_camera_button'),
                                  customBorder: const CircleBorder(),
                                  onTap: (_isLoading || _isUploadingPhoto)
                                      ? null
                                      : _handlePickPhoto,
                                  child: const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.camera_alt_rounded,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      AuthTextField(
                        fieldKey: const Key('edit_name_field'),
                        label: 'Nama Lengkap',
                        hintText: 'Masukkan nama lengkap',
                        controller: _nameController,
                        focusNode: _nameFocus,
                        prefixIcon: Icons.person_outline_rounded,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.done,
                        enabled: !_isLoading,
                        validator: AuthValidators.validateName,
                        onFieldSubmitted: (_) => _handleSave(),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      AuthTextField(
                        fieldKey: const Key('edit_email_field'),
                        label: 'Email',
                        hintText: 'nama@sekolah.sch.id',
                        controller: _emailController,
                        prefixIcon: Icons.email_outlined,
                        enabled: false,
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      VoltButton(
                        key: const Key('edit_save_button'),
                        label: _isLoading ? 'Menyimpan...' : 'Simpan Perubahan',
                        fullWidth: true,
                        onPressed: _isLoading ? null : _handleSave,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
