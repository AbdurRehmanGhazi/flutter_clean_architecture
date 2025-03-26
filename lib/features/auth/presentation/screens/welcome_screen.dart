import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/constants/list_translation_locale.dart';
import 'package:flutter_clean_architecture/core/theme/app_colors.dart';
import 'package:flutter_clean_architecture/core/theme/theme_bloc/theme_bloc.dart';
import 'package:flutter_clean_architecture/translations/locale_keys.g.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/native_classes/langugage_manager.dart';
import '../../../../widgets/buttons/primary_button.dart';
import '../../../../widgets/classes/custom_page_route.dart';
import '../../../../widgets/labels/description_text.dart';
import '../../../../widgets/buttons/gradient_button.dart';
import '../../../../widgets/gradient_icon.dart';
import '../../../../widgets/labels/title_text.dart';
import '../../../../features/auth/presentation/screens/mobile_number_verification_screen.dart';
import '../../../../rounter/app_route_config.dart';
import '../../../../rounter/app_route_utils.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _WelcomeView();
  }
}

class _WelcomeView extends StatelessWidget {
  const _WelcomeView({super.key});

  _navToMobileNumberVerificationScreen(BuildContext context) {
    context.pushNamed(AppRoute.mobileNumberVerification.toName);
  }

  _navToLoginScreen(BuildContext context) {
    context.pushNamed(AppRoute.login.toName);
  }

  _getLocaleButtons(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          PrimaryButton(
            onPressed: () async {
              await context.setLocale(englishLocale);
              if (Platform.isIOS) await LanguageManager.setPreferredLanguage(englishLanguageCode);
            },
            buttonText: 'English',
          ),
          PrimaryButton(
            onPressed: () async {
              await context.setLocale(somaliaLocale);
              if (Platform.isIOS) await LanguageManager.setPreferredLanguage(somaliaLanguageCode);
            },
            buttonText: 'Somali',
          ),
          PrimaryButton(
            onPressed: () async {
              await context.setLocale(arabicLocale);
              if (Platform.isIOS) await LanguageManager.setPreferredLanguage(arabicLanguageCode);
            },
            buttonText: 'Arabic',
          )
        ],
      );

  _getThemeButtons(BuildContext context) => Column(
    children: [
      Wrap(
        direction: Axis.horizontal,
        spacing: 16,
        runSpacing: 16,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PrimaryButton(
            onPressed: () {
              context.read<ThemeBloc>().add(SetThemeEvent(AppThemeMode.system));
            },
            buttonText: 'System Mode',
          ),
          PrimaryButton(
            onPressed: () {
              context.read<ThemeBloc>().add(SetThemeEvent(AppThemeMode.light));
            },
            buttonText: 'Light Mode',
          ),
          PrimaryButton(
            onPressed: () {
              context.read<ThemeBloc>().add(SetThemeEvent(AppThemeMode.dark));
            },
            buttonText: 'Dark Mode',
          ),
        ],
      ),
      SizedBox(height: 16,),
      Icon(context.watch<ThemeBloc>().state.themeIcon, size: 32, color: AppColors.primaryTextColor,)
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(children: [
              const GradientIcon(icon: Icons.data_saver_off, size: 120,),
              const SizedBox(height: 16),
              TitleText(text: LocaleKeys.welcomeToSaveKaro.tr()),
              const SizedBox(height: 8),
              DescriptionText(text: LocaleKeys.easySaveYourMoney.tr()),
              const SizedBox(height: 60),
              GradientButton(buttonText: LocaleKeys.signUp.tr(), onPressed: () => _navToMobileNumberVerificationScreen(context)),
              const SizedBox(height: 24),
              GradientButton(buttonText: LocaleKeys.login.tr(), onPressed: () => _navToLoginScreen(context)),
              SizedBox(height: 32),
              _getLocaleButtons(context),
              SizedBox(height: 16),
              _getThemeButtons(context)
              ],),
          ),
        ),
      ),
    );
  }
}
