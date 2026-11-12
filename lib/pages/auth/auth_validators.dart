/// Tingkat kekuatan password untuk indikator visual di RegisterPage.
enum PasswordStrength {
  none,
  weak,
  medium,
  strong;

  String get label => switch (this) {
    PasswordStrength.none => '',
    PasswordStrength.weak => 'Lemah',
    PasswordStrength.medium => 'Sedang',
    PasswordStrength.strong => 'Kuat',
  };

  double get progress => switch (this) {
    PasswordStrength.none => 0.0,
    PasswordStrength.weak => 0.33,
    PasswordStrength.medium => 0.66,
    PasswordStrength.strong => 1.0,
  };
}

/// Fungsi murni validator autentikasi EduVolt.
abstract final class AuthValidators {
  static final RegExp _emailRegex = RegExp(
    r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
  );

  static String? validateName(String? value) {
    final String clean = (value ?? '').trim();
    if (clean.isEmpty) {
      return 'Nama lengkap wajib diisi';
    }
    if (clean.length < 2) {
      return 'Nama lengkap minimal 2 karakter';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final String clean = (value ?? '').trim();
    if (clean.isEmpty) {
      return 'Email wajib diisi';
    }
    if (!_emailRegex.hasMatch(clean)) {
      return 'Format email tidak valid';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    final String raw = value ?? '';
    if (raw.isEmpty) {
      return 'Password wajib diisi';
    }
    if (raw.length < 6) {
      return 'Password minimal 6 karakter';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    final String raw = value ?? '';
    if (raw.isEmpty) {
      return 'Konfirmasi password wajib diisi';
    }
    if (raw != password) {
      return 'Konfirmasi password tidak cocok';
    }
    return null;
  }

  static PasswordStrength evaluatePasswordStrength(String password) {
    if (password.isEmpty) {
      return PasswordStrength.none;
    }
    if (password.length < 6) {
      return PasswordStrength.weak;
    }
    final bool hasLetter = RegExp(r'[A-Za-z]').hasMatch(password);
    final bool hasDigit = RegExp(r'\d').hasMatch(password);
    final bool hasSymbol = RegExp(r'[^A-Za-z0-9]').hasMatch(password);
    final int varietyCount =
        (hasLetter ? 1 : 0) + (hasDigit ? 1 : 0) + (hasSymbol ? 1 : 0);

    if (password.length >= 8 && varietyCount >= 2) {
      return PasswordStrength.strong;
    }
    if (password.length >= 6 && varietyCount >= 2) {
      return PasswordStrength.medium;
    }
    return PasswordStrength.weak;
  }
}
