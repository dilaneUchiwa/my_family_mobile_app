import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_family_mobile_app/controllers/registerController.dart';
import 'package:my_family_mobile_app/themes/theme.dart';
import 'package:my_family_mobile_app/views/components/common_button.dart';
import 'package:my_family_mobile_app/views/components/form_input_field.dart';

class RegisterPage extends StatelessWidget {
  final RegisterController registerController = Get.put(RegisterController());
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        title: Text('registration'.tr),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              FormInputField(
                labelText: 'register.username'.tr,
                fieldValidator: (value) {
                  if (value!.isEmpty) {
                    return 'input.error_enter_username'.tr;
                  }
                  return null;
                },
                controller: registerController.usernameTextController,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),
              FormInputField(
                labelText: 'register.email'.tr,
                fieldValidator: (value) {
                  if (value!.isEmpty) {
                    return 'input.error_enter_email'.tr;
                  }
                  if (!value.isEmail) {
                    return 'input.error_invalid_email'.tr;
                  }
                  return null;
                },
                controller: registerController.emailTextController,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              FormInputField(
                labelText: 'register.password'.tr,
                fieldValidator: (value) {
                  if (value!.isEmpty) {
                    return 'input.error_enter_password'.tr;
                  }
                  if (value.length < 6) {
                    return 'input.error_password_length'.tr;
                  }
                  return null;
                },
                controller: registerController.passwordTextController,
                password: true,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),
              FormInputField(
                labelText: 'register.confirm_password'.tr,
                onChanged: (value) {
                    if (value != registerController.passwordTextController.text) {
                    _formKey.currentState!.validate();
                    }
                },
                fieldValidator: (value) {
                  if (value!.isEmpty) {
                    return 'input.error_confirm_password'.tr;
                  }
                  if (value != registerController.passwordTextController.text) {
                    return 'input.error_passwords_dont_match'.tr;
                  }
                  return null;
                },
                controller: registerController.confirmPasswordTextController,
                password: true,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 30),
              CommonButton(
                () {
                  if (_formKey.currentState!.validate()) {
                    registerController.register();
                  }
                },
                'register.submit'.tr,
                Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
