import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider_base/common/core/theme/appTheme_state_notifier.dart';

class SwitchThemebutton extends HookConsumerWidget {
  const SwitchThemebutton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(appThemeProvider);

    return Switch.adaptive(
      onChanged: (value) {
        ref.read(appThemeProvider.notifier).toggleAppTheme();
      },
      value: themeProvider.onDarkMode,
    );
  }
}
