import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider_base/common/common_view/common_button.dart';
import 'package:provider_base/common/common_view/common_text_field.dart';
import 'package:provider_base/common/core/app_style.dart';
import 'package:provider_base/screens/form_and_dialog/form_state_notifier.dart';
import 'package:provider_base/utils/utils.dart';

class FormAndDialogScreen extends StatelessWidget with Utils {
  const FormAndDialogScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: getAppBar(
          title: 'Form screen',
          centerTitle: true,
          pressBack: () => Navigator.of(
            context,
            rootNavigator: true,
          ).pop(context),
        ),
        body: FormBody(
          formKey: _formKey,
        ),
      ),
    );
  }
}

class FormBody extends HookConsumerWidget with Utils {
  const FormBody({Key? key, required this.formKey}) : super(key: key);

  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(formNotifierProvider);
    final formStateNotifier = ref.read(formNotifierProvider.notifier);

    final passwordValidator = MultiValidator([
      RequiredValidator(errorText: 'Password is required'),
      MinLengthValidator(8,
          errorText: 'Password must be at least 8 digits long'),
      PatternValidator(r'(?=.*?[#?!@$%^&*-])',
          errorText: 'Passwords must have at least one special character')
    ]);

    final emailValidator = MultiValidator([
      RequiredValidator(errorText: 'Email is required'),
      EmailValidator(errorText: 'Enter a valid email address')
    ]);

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return SingleChildScrollView(
      padding:
          const EdgeInsets.symmetric(horizontal: AppStyles.horizontalSpace),
      child: Column(
        children: [
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormFieldCustom(
                    suffixIcon: const Icon(Icons.email_outlined),
                    controller: emailController,
                    hintText: 'Email',
                    validator: emailValidator),
                const SizedBox(
                  height: 20,
                ),
                TextFormFieldCustom(
                  controller: passwordController,
                  obscureText: !formState.showPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      formState.showPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: formStateNotifier.showPassword,
                  ),
                  hintText: 'Password',
                  validator: passwordValidator,
                ),
                const SizedBox(
                  height: 50,
                ),
                CommonButton.submitBtn('Submit', () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                }),
              ],
            ),
          ),
          Column(
            children: [
              _rowDialog(
                context,
                'Ok dialog',
                () => showOkAlertDialog(
                    context: context,
                    title: 'Title',
                    message: 'This is message'),
              ),
              _rowDialog(
                context,
                'Confirm dialog',
                () => showConfirmationDialog(
                  context: context,
                  title: 'Title',
                  message: 'This is message',
                ),
              ),
              _rowDialog(
                context,
                'Ok cancel dialog',
                () => showOkCancelAlertDialog(
                  context: context,
                  title: 'Title',
                  message: 'This is message',
                ),
              ),
              _rowDialog(
                context,
                'Modal action sheet',
                () => showModalActionSheet(
                  context: context,
                  title: 'Title',
                  message: 'This is message',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _rowDialog(
      BuildContext context, String message, VoidCallback? voidCallback) {
    return Padding(
      padding: const EdgeInsets.only(top: AppStyles.verticalSpace),
      child: GestureDetector(
        onTap: voidCallback,
        child: Chip(
          label: Text(
            message,
            style: AppStyles.textMedium.copyWith(
              color: AppStyles.white,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: AppStyles.verticalSpace,
            horizontal: AppStyles.horizontalSpace,
          ),
          backgroundColor: AppStyles.primaryColor,
        ),
      ),
    );
  }
}
