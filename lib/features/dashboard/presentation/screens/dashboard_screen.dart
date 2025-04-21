import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/utils/sdp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/list_translation_locale.dart';
import '../../../../core/theme/theme_bloc/theme_bloc.dart';
import '../../../../core/utils/native_classes/langugage_manager.dart';
import '../../../../widgets/buttons/primary_button.dart';
import '../../../../widgets/classes/custom_page_route.dart';
import '../../../../widgets/styles/custom_container_box_decoration.dart';
import '../../../../widgets/styles/gradeint_container.dart';
import '../../../../widgets/labels/description_text.dart';
import '../../../../widgets/labels/title_text.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../rounter/app_route_utils.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
      Icon(context.watch<ThemeBloc>().state.themeIcon, size: 32.sdp, color: Theme.of(context).textTheme.bodyMedium?.color)
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save Kro'),
        leading: IconButton(
            onPressed: () {
              context.pushNamed(AppRoute.settings.toName);
            },
            icon: const Icon(Icons.account_circle_outlined),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.sdp, horizontal: 16.sdp),
            child: Column(
              children: [
                GradientContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TitleText(text: 'Save Kro', color: Theme.of(context).primaryColorLight, fontSize: 16.sdp, fontWeight: FontWeight.bold),
                      SizedBox(height: 8.sdp),
                      DescriptionText(text: 'Current Balance', color: Theme.of(context).primaryColorLight),
                      Row(
                        children: [
                          TitleText(text: 'Rs. 23,222.00 ', color: Theme.of(context).primaryColorLight, fontSize: 16.sdp, fontWeight: FontWeight.bold),
                          Icon(Icons.keyboard_arrow_right_rounded, color: Theme.of(context).primaryColorLight),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.refresh, color: Theme.of(context).primaryColorLight),
                          SizedBox(width: 12.sdp),
                          DescriptionText(text: 'Updated Just Now', color: Theme.of(context).primaryColorLight),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                              foregroundColor: WidgetStatePropertyAll(Theme.of(context).primaryColorLight)
                            ),
                            child: const Text('Sign In'),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 24.sdp),
                Row(
                  children: [
                    ImageTopButton(text: 'Send Money', onTap: (){}),
                    SizedBox(width: 16.sdp),
                    ImageTopButton(text: 'Add Money', onTap: (){}),
                    SizedBox(width: 16.sdp),
                    ImageTopButton(text: 'Withdrawal', onTap: (){}),
                  ],
                ),
                SizedBox(height: 32.sdp),
                _getLocaleButtons(context),
                SizedBox(height: 16.sdp),
                _getThemeButtons(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageTopButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onTap;

  const ImageTopButton({super.key, required this.text, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            decoration: createCustomBorder(allRadius: 20, all: true, borderColor: Theme.of(context).primaryColor),
            child: DescriptionText(text: text),
          ),
        ),
      ),
    );
  }
}
