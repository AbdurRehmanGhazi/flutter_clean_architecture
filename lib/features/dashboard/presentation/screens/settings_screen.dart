import 'package:flutter_clean_architecture/widgets/dialogs/adaptive_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/utils/sdp.dart';
import 'package:go_router/go_router.dart';
import '../../../../widgets/classes/custom_page_route.dart';
import '../../../../widgets/styles/custom_container_box_decoration.dart';
import '../../../../widgets/styles/gradeint_container.dart';
import '../../../../widgets/labels/description_text.dart';
import '../../../../widgets/labels/title_text.dart';
import '../../../../core/secrets/shared_preference.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../rounter/app_route_utils.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final options = ['Transactions', 'Logout'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Account')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.sdp, horizontal: 16.sdp),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GradientContainer(
                  child: Row(
                    children: [
                      Container(
                        height: 60.sdp,
                        width: 60.sdp,
                        decoration: createCustomBorder(allRadius: 30.sdp, bgColor: Theme.of(context).scaffoldBackgroundColor),
                        child: Center(child: DescriptionText(text: 'AR', fontSize: 16.sdp, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(width: 12.sdp),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TitleText(text: 'Abdul Samad', color: Theme.of(context).primaryColorLight, fontSize: 16.sdp, fontWeight: FontWeight.bold),
                                const Spacer(),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                                      foregroundColor: WidgetStatePropertyAll(Theme.of(context).primaryColorLight)
                                  ),
                                  child: const Text('Edit'),
                                ),
                              ],
                            ),
                            TitleText(text: '0335-2388222', color: Theme.of(context).primaryColorLight, fontSize: 16.sdp, fontWeight: FontWeight.bold),
                            DescriptionText(text: 'abdursamad@gmail.com', color: Theme.of(context).primaryColorLight),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.sdp),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        if (index == options.length - 1) {
                          AdaptiveAlertDialog.show(
                              context, title: 'Logout',
                              content: 'Are you sure to logout?',
                              yesButtonTitle: 'Yes',
                              noButtonTitle: 'No',
                              onYesPressed: () async {
                                await SharedPreference.saveLogin(false);
                                final isRemember = await SharedPreference.getRememberMe();
                                context.go(isRemember ? AppRoute.login.toPath : AppRoute.mobileNumberVerification.toPath);

                              },
                              onNoPressed: () {},
                          );
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8.sdp),
                        padding: const EdgeInsets.all(16),
                        decoration: createCustomBorder(allRadius: 8, all: true, borderColor: Theme.of(context).primaryColor),
                        child: DescriptionText(text: options[index]),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
