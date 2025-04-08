class EmailValidator {
  static String? validate(String email) {
    if (email.isEmpty) return "Email cannot be empty";
    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(email)) {
      return "Enter a valid email address";
    }
    return null;
  }
}