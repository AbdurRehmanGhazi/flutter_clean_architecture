import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../widgets/classes/custom_page_route.dart';
import '../../../../widgets/styles/custom_container_box_decoration.dart';
import '../../../../widgets/styles/gradeint_container.dart';
import '../../../../widgets/labels/description_text.dart';
import '../../../../widgets/labels/title_text.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../rounter/app_route_utils.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Column(
              children: [
                GradientContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TitleText(text: 'Save Kro', color: AppPalette.whiteColor, fontSize: 16, fontWeight: FontWeight.bold),
                      const SizedBox(height: 8,),
                      DescriptionText(text: 'Current Balance', color: AppPalette.whiteColor),
                      Row(
                        children: [
                          TitleText(text: 'Rs. 23,222.00 ', color: AppPalette.whiteColor, fontSize: 16, fontWeight: FontWeight.bold),
                          Icon(Icons.keyboard_arrow_right_rounded, color: AppPalette.whiteColor),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.refresh, color: AppPalette.whiteColor),
                          const SizedBox(width: 12,),
                          DescriptionText(text: 'Updated Just Now', color: AppPalette.whiteColor),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(AppPalette.transparentColor),
                              foregroundColor: WidgetStatePropertyAll(AppPalette.whiteColor)
                            ),
                            child: const Text('Sign In'),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    ImageTopButton(text: 'Send Money', onTap: (){}),
                    SizedBox(width: 16),
                    ImageTopButton(text: 'Add Money', onTap: (){}),
                    SizedBox(width: 16),
                    ImageTopButton(text: 'Withdrawal', onTap: (){})
                  ],
                )
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
            decoration: createCustomBorder(allRadius: 20, all: true, borderColor: AppPalette.primaryBorderColor),
            child: DescriptionText(text: text),
          ),
        ),
      ),
    );
  }
}
