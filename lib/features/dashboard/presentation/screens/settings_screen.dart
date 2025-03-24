import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/classes/custom_page_route.dart';
import '../../../../core/widgets/styles/custom_container_box_decoration.dart';
import '../../../../core/widgets/styles/gradeint_container.dart';
import '../../../../core/widgets/labels/description_text.dart';
import '../../../../core/widgets/labels/title_text.dart';
import '../../../../core/secrets/shared_preference.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../rounter/app_route_utils.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final options = ['Transactions', 'Logout'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Account')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GradientContainer(
                child: Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: createCustomBorder(allRadius: 30, bgColor: AppPalette.secondaryBackgroundColor),
                      child: Center(child: TitleText(text: 'AR', weight: FontWeight.bold)),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const TitleText(text: 'Abdul Samad', weight: FontWeight.bold),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(AppPalette.transparentColor),
                                    foregroundColor: WidgetStatePropertyAll(AppPalette.primaryTextColor)
                                ),
                                child: const Text('Edit'),
                              ),
                            ],
                          ),
                          TitleText(text: '0335-2388222', weight: FontWeight.bold,),
                          const DescriptionText(text: 'abdursamad@gmail.com'),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      if (index == options.length - 1) {
                        await SharedPreference.saveLogin(false);
                        context.go(AppRoute.welcome.toPath);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8,),
                      padding: const EdgeInsets.all(16),
                      decoration: createCustomBorder(allRadius: 8, all: true, borderColor: AppPalette.primaryBorderColor),
                      child: TitleText(text: options[index]),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
