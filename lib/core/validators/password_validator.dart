class PasswordValidator {
  static String? validate(String password) {
    if (password.isEmpty) return "Password cannot be empty";
    if (password.length < 6) return "Password must be at least 6 characters";
    if (!RegExp(r'[A-Z]').hasMatch(password)) return "Password must contain at least one uppercase letter";
    if (!RegExp(r'[0-9]').hasMatch(password)) return "Password must contain at least one number";
    return null;
  }
}
