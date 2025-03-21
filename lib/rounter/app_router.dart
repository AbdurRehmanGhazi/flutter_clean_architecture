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
import 'route_utils.dart';

class AppRouter {
  GoRouter get router => _goRouter;

  String initialRoutePath;
  AppRouter({required this.initialRoutePath});

  late final GoRouter _goRouter = GoRouter(
    // refreshListenable: appService,
    initialLocation: initialRoutePath,  // APP_PAGE.welcome.toPath,
    observers: [SnackBarObserver()],
    navigatorKey: globalNavigatorKey,
    routes: <GoRoute>[
      GoRoute(
        path: APP_PAGE.welcome.toPath,
        name: APP_PAGE.welcome.toName,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: APP_PAGE.mobileNumberVerification.toPath,
        name: APP_PAGE.mobileNumberVerification.toName,
        builder: (context, state) => const MobileNumberVerificationScreen(),
      ),
      GoRoute(
        path: APP_PAGE.otpVerification.toPath,
        name: APP_PAGE.otpVerification.toName,
        builder: (context, state) {
          final res = state.extra as MobileNumberVerificationResponse;
          return OTPVerificationScreen(mobileNumberVerificationResponse: res);
        },
      ),
      GoRoute(
        path: APP_PAGE.registration.toPath,
        name: APP_PAGE.registration.toName,
        builder: (context, state) {
          final String mobileNumber = state.extra as String;
          return RegistrationScreen(mobileNumber: mobileNumber);
        },
      ),
      GoRoute(
        path: APP_PAGE.login.toPath,
        name: APP_PAGE.login.toName,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: APP_PAGE.dashboard.toPath,
        name: APP_PAGE.dashboard.toName,
        builder: (context, state) {
          return const DashboardScreen();
        },
      ),
      GoRoute(
        path: APP_PAGE.settings.toPath,
        name: APP_PAGE.settings.toName,
        builder: (context, state) {
          return SettingsScreen();
        },
      ),
    ],
    errorBuilder: (context, state) => ErrorPage(error: state.error.toString()),
  );
}