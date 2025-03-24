enum AppRoute {
  welcome,
  mobileNumberVerification,
  otpVerification,
  registration,
  login,
  dashboard,
  settings,
}

extension AppPageExtension on AppRoute {
  String get toPath {
    switch (this) {
      case AppRoute.welcome:
        return "/";
      case AppRoute.mobileNumberVerification:
        return "/mobileNumberVerification";
      case AppRoute.otpVerification:
        return "/otpVerification";
      case AppRoute.registration:
        return "/registration";
        case AppRoute.login:
        return "/login";
        case AppRoute.dashboard:
        return "/dashboard";
        case AppRoute.settings:
        return "/settings";
      default:
        return "/";
    }
  }

  String get toName {
    switch (this) {
      case AppRoute.welcome:
        return "WELCOME";
      case AppRoute.mobileNumberVerification:
        return "MOBILE NUMBER VERIFICATION";
      case AppRoute.otpVerification:
        return "OTP VERIFICATION";
      case AppRoute.registration:
        return "REGISTRATION";
        case AppRoute.login:
        return "LOGIN";
        case AppRoute.dashboard:
        return "DASHBOARD";
        case AppRoute.settings:
        return "SETTINGS";
      default:
        return "WELCOME";
    }
  }

}