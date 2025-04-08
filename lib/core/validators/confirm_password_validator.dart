class ConfirmPasswordValidator {
  static String? validate(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) return "Confirm Password cannot be empty";
    if (password != confirmPassword) return "Password & Confirm Password do not match";
    return null;
  }
}
