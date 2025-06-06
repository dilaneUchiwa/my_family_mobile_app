import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_family_mobile_app/controllers/loginController.dart';
import 'package:my_family_mobile_app/themes/theme.dart';
import 'package:my_family_mobile_app/utils/appImages.dart';
import 'package:my_family_mobile_app/utils/storageConstant.dart';
import 'package:my_family_mobile_app/views/components/common_button.dart';
import 'package:my_family_mobile_app/views/components/form_input_field.dart';


class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final LoginController loginController = Get.put(LoginController());
  final dynamic arguments = Get.arguments;
  final FocusNode _nodeText1 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        title: Text(
          'B.I.A. DigiBank'.tr,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: InkWell(
            onTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Image(
                  image: AssetImage('assets/menu.png'),
                  color: AppColors.white,
                ))),
        // brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
        elevation: 0.0,
        automaticallyImplyLeading: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
            decoration: BoxDecoration(
              color: AppColors.primary,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'welcome_back'.tr,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Welcome ${GetStorage().read(StorageConstants.fullName) == null ? "and" : 'Back ${GetStorage().read(StorageConstants.fullName)}'} Log In to continue',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            alignment: Alignment.center,
            child: Image.asset(
              AppImages.logoLight,
              width: 200,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20).copyWith(
              top: 30,
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                      FormInputField(
                      // prefixIcon: Row(
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: [
                      //     SvgIcon(
                      //       AppImages.phone,
                      //       width: 20,
                      //     ),
                      //   ],
                      // ),
                      focusNode: _nodeText1,
                      labelText: 'login.username'.tr,
                      fieldValidator: (value) {
                        if (value!.isEmpty) {
                          return 'input.username.error'.tr;
                        }
                        return null;
                      },
                      password: false,
                      textInputType: TextInputType.text,
                      inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
                      textInputAction: TextInputAction.next,
                      controller: loginController.idTextController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormInputField(
                      // prefixIcon: SvgIcon(
                      //   AppImages.lock,
                      //   width: 25,
                      // ),
                      labelText: 'register.customer.password'.tr,
                      fieldValidator: (value) {
                        if (value!.isEmpty) {
                          return 'error_enter_password'.tr;
                        }
                        return null;
                      },
                      password: true,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      controller: loginController.passwordTextController,
                    ),
                    Obx(() {
                      return Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Checkbox(
                                    activeColor: Theme.of(context).primaryColor,
                                    value: loginController.rememberMe.value,
                                    onChanged: (bool? value) {
                                      loginController.rememberMe.value =
                                          !loginController.rememberMe.value;
                                      GetStorage().write(
                                          StorageConstants.rememberMe,
                                          loginController.rememberMe.value);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    loginController.rememberMe.value =
                                        !loginController.rememberMe.value;
                                    GetStorage().write(
                                        StorageConstants.rememberMe,
                                        loginController.rememberMe.value);
                                  },
                                  child: Text(
                                    "login.remember_me".tr,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                      fontFamily: "Arial",
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ]),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed('/forgot_password');
                                },
                                child: Text(
                                  "login.forgot_password".tr,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontFamily: "Arial",
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ]),
                      );
                    }),
                    SizedBox(
                      height: 30,
                    ),
                    CommonButton(() {
                      if (_formKey.currentState?.validate() == true) {
                        FocusScope.of(context).unfocus();
                        loginController.authenticate();
                      }
                    }, 'home.screen.login'.tr,
                        Theme.of(context).colorScheme.secondary),
                    SizedBox(
                      height: 25,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        "${'login.you_dont_have_account'.tr} ",
                        style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Arial"),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/register');
                        },
                        child: Text(
                          'register'.tr,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Arial"),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
