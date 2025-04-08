class UsernameValidator {
  static String? validate(String username) {
    if (username.isEmpty) return "Username cannot be empty";
    if (username.length < 3) return "Username must be at least 3 characters";
    if (!RegExp(r"^[a-zA-Z0-9_]+$").hasMatch(username)) {
      return "Username can only contain letters, numbers, and underscores";
    }
    return null;
  }
}
