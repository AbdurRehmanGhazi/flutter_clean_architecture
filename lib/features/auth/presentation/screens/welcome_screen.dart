import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/list_translation_locale.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_bloc/theme_bloc.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../../core/utils/native_classes/langugage_manager.dart';
import '../../../../widgets/buttons/primary_button.dart';
import '../../../../core/utils/sdp.dart';
import '../../../../widgets/labels/description_text.dart';
import '../../../../widgets/buttons/gradient_button.dart';
import '../../../../widgets/gradient_icon.dart';
import '../../../../widgets/labels/title_text.dart';
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
        spacing: 16.sdp,
        runSpacing: 16.sdp,
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
      SizedBox(height: 16.sdp,),
      Icon(context.watch<ThemeBloc>().state.themeIcon, size: 32.sdp, color: AppColors.primaryTextColor,)
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.sdp),
          child: Center(
            child: SingleChildScrollView(
              child: Column(children: [
                GradientIcon(icon: Icons.data_saver_off, size: 120),
                SizedBox(height: 16.sdp),
                TitleText(text: LocaleKeys.welcomeToSaveKaro.tr()),
                SizedBox(height: 8.sdp),
                DescriptionText(text: LocaleKeys.easySaveYourMoney.tr()),
                SizedBox(height: 60.sdp),
                GradientButton(buttonText: LocaleKeys.signUp.tr(), onPressed: () => _navToMobileNumberVerificationScreen(context)),
                SizedBox(height: 24.sdp),
                GradientButton(buttonText: LocaleKeys.login.tr(), onPressed: () => _navToLoginScreen(context)),
                SizedBox(height: 32.sdp),
                _getLocaleButtons(context),
                SizedBox(height: 16.sdp),
                _getThemeButtons(context)
                ],),
            ),
          ),
        ),
      ),
    );
  }
}
