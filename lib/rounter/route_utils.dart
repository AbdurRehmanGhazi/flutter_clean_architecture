enum APP_PAGE {
  welcome,
  mobileNumberVerification,
  otpVerification,
  registration,
  login,
  dashboard,
  settings,
}

extension AppPageExtension on APP_PAGE {
  String get toPath {
    switch (this) {
      case APP_PAGE.welcome:
        return "/";
      case APP_PAGE.mobileNumberVerification:
        return "/mobileNumberVerification";
      case APP_PAGE.otpVerification:
        return "/otpVerification";
      case APP_PAGE.registration:
        return "/registration";
        case APP_PAGE.login:
        return "/login";
        case APP_PAGE.dashboard:
        return "/dashboard";
        case APP_PAGE.settings:
        return "/settings";
      default:
        return "/";
    }
  }

  String get toName {
    switch (this) {
      case APP_PAGE.welcome:
        return "WELCOME";
      case APP_PAGE.mobileNumberVerification:
        return "MOBILE NUMBER VERIFICATION";
      case APP_PAGE.otpVerification:
        return "OTP VERIFICATION";
      case APP_PAGE.registration:
        return "REGISTRATION";
        case APP_PAGE.login:
        return "LOGIN";
        case APP_PAGE.dashboard:
        return "DASHBOARD";
        case APP_PAGE.settings:
        return "SETTINGS";
      default:
        return "WELCOME";
    }
  }

}