import 'package:go_router/go_router.dart';
import '../features/auth/domain/entities/mobile_number_verification_response.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/mobile_number_verification_screen.dart';
import '../features/auth/presentation/screens/otp_verification_screen.dart';
import '../features/auth/presentation/screens/registration_screen.dart';
import '../features/auth/presentation/screens/welcome_screen.dart';
import '../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../features/dashboard/presentation/screens/settings_screen.dart';
import '../main.dart';
import '../rounter/error_page.dart';
import '../core/utils/snackbar_observer.dart';
import 'app_route_utils.dart';

class AppRouterConfig {
  GoRouter get router => _goRouter;

  String initialRoutePath;
  AppRouterConfig({required this.initialRoutePath});

  late final GoRouter _goRouter = GoRouter(
    // refreshListenable: appService,
    initialLocation: initialRoutePath,  // APP_PAGE.welcome.toPath,
    observers: [SnackBarObserver()],
    navigatorKey: globalNavigatorKey,
    routes: <GoRoute>[
      GoRoute(
        path: AppRoute.welcome.toPath,
        name: AppRoute.welcome.toName,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: AppRoute.mobileNumberVerification.toPath,
        name: AppRoute.mobileNumberVerification.toName,
        builder: (context, state) => const MobileNumberVerificationScreen(),
      ),
      GoRoute(
        path: AppRoute.otpVerification.toPath,
        name: AppRoute.otpVerification.toName,
        builder: (context, state) {
          final res = state.extra as MobileNumberVerificationResponse;
          return OTPVerificationScreen(mobileNumberVerificationResponse: res);
        },
      ),
      GoRoute(
        path: AppRoute.registration.toPath,
        name: AppRoute.registration.toName,
        builder: (context, state) {
          final String mobileNumber = state.extra as String;
          return RegistrationScreen(mobileNumber: mobileNumber);
        },
      ),
      GoRoute(
        path: AppRoute.login.toPath,
        name: AppRoute.login.toName,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: AppRoute.dashboard.toPath,
        name: AppRoute.dashboard.toName,
        builder: (context, state) {
          return const DashboardScreen();
        },
      ),
      GoRoute(
        path: AppRoute.settings.toPath,
        name: AppRoute.settings.toName,
        builder: (context, state) {
          return SettingsScreen();
        },
      ),
    ],
    errorBuilder: (context, state) => ErrorPage(error: state.error.toString()),
  );
}