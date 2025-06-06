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
      body: Builder(builder: (context) {
        return Stack(
          children: [
            SizedBox(
              width: Get.size.width,
              height: Get.size.height,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormInputField(
                        labelText: 'register.title'.tr,
                        fieldValidator: (value) => value!.isEmpty
                            ? 'input.error_enter_title'.tr
                            : null,
                        controller: registerController.titleTextController,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 20),
                      FormInputField(
                        labelText: 'register.firstName'.tr,
                        fieldValidator: (value) => value!.isEmpty
                            ? 'input.error_enter_firstname'.tr
                            : null,
                        controller: registerController.firstNameTextController,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 20),
                      FormInputField(
                        labelText: 'register.lastName'.tr,
                        fieldValidator: (value) => value!.isEmpty
                            ? 'input.error_enter_lastname'.tr
                            : null,
                        controller: registerController.lastNameTextController,
                        textInputAction: TextInputAction.next,
                      ),
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
                      InkWell(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: registerController.birthDate.value,
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            registerController.updateBirthDate(picked);
                          }
                        },
                        child: FormInputField(
                          labelText: 'register.birthDate'.tr,
                          controller:
                              registerController.birthDateTextController,
                          enabled: false,
                        ),
                      ),
                      SizedBox(height: 20),
                      Obx(() => DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                                labelText: 'register.gender'.tr),
                            value: registerController.selectedGender.value,
                            items:
                                registerController.genders.map((String gender) {
                              return DropdownMenuItem(
                                value: gender,
                                child: Text(gender.tr),
                              );
                            }).toList(),
                            onChanged: (value) => registerController
                                .selectedGender.value = value!,
                          )),
                      SizedBox(height: 20),
                      FormInputField(
                        labelText: 'register.address'.tr,
                        controller: registerController.addressTextController,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 20),
                      FormInputField(
                        labelText: 'register.phone'.tr,
                        controller: registerController.phoneTextController,
                        textInputType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 20),
                      Text('register.interests'.tr,
                          style: Theme.of(context).textTheme.titleMedium),
                      Obx(() => Wrap(
                            spacing: 8,
                            children: registerController.availableInterests
                                .map((interest) {
                              return FilterChip(
                                label: Text(interest),
                                selected: registerController.selectedInterests
                                    .contains(interest),
                                onSelected: (_) =>
                                    registerController.toggleInterest(interest),
                              );
                            }).toList(),
                          )),
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
                          _formKey.currentState!.validate();
                        },
                        fieldValidator: (value) {
                          if (value!.isEmpty) {
                            return 'input.error_confirm_password'.tr;
                          }
                          if (value !=
                              registerController.passwordTextController.text) {
                            return 'input.error_passwords_dont_match'.tr;
                          }
                          return null;
                        },
                        controller:
                            registerController.confirmPasswordTextController,
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
            ),
            Obx(
              () => registerController.isLoading.value
                  ? Container(
                      color: Colors.black.withOpacity(0.5),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        );
      }),
    );
  }
}
