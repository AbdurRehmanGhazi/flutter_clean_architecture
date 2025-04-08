class PhoneValidator {
  static String? validate(String phone) {
    if (phone.isEmpty) return "Phone number cannot be empty";
    if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(phone)) {
      return "Enter a valid phone number";
    }
    return null;
  }
}
