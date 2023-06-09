import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider_base/common/common_view/switch_theme_button.dart';
import 'package:provider_base/common/core/app_style.dart';
import 'package:provider_base/common/core/routes.dart';
import 'package:provider_base/l10n/l10n.dart';
import 'package:provider_base/main/app.dart';
import 'package:provider_base/utils/utils.dart';

class ModulesScreen extends HookConsumerWidget with Utils {
  const ModulesScreen({Key? key}) : super(key: key);

  static String routeName = '/list_modules';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, String> listModules = {
      'Dashboard': Routes.dashboardScreen,
      'Authorization': Routes.loginScreen,
      'Util': Routes.utilScreen,
      'Notification': '/notification',
      'Take Picture': '/take_picture',
      'Google\n Analysis': '/google_analysis',
      'OTP/Capcha': '/otp_capcha',
      'QR Code': Routes.qrCodeScreen,
      'Play Video': '/play_video',
    };

    return Scaffold(
      appBar: getAppBar(
          centerTitle: false,
          title: L10n.of(context).msgap001,
          actions: const [SwitchThemebutton()]),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
            clipBehavior: Clip.none,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: AppStyles.gridViewSpace,
              mainAxisSpacing: AppStyles.gridViewSpace,
            ),
            itemCount: listModules.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) => _buildGridItem(
              context,
              ref,
              listModules.keys.elementAt(index),
              listModules.values.elementAt(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(
    BuildContext context,
    WidgetRef ref,
    String title,
    String routeName,
  ) {
    return GestureDetector(
      onTap: () {
        // try GG analytics
        ref.read(analyticsUtilProvider).setCurrentScreen(routeName);
        ref.read(analyticsUtilProvider).setUserId('1');
        ref
            .read(analyticsUtilProvider)
            .setUserProperty(name: 'age', value: '29');
        return pushName(context, routeName);
      },
      child: Container(
        alignment: Alignment.center,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              offset: const Offset(4, 4),
              blurRadius: 15,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Theme.of(context).primaryColor,
              offset: const Offset(-4, -4),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
      ),
    );
  }
}
