import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_family_mobile_app/controllers/registerController.dart';
import 'package:my_family_mobile_app/themes/theme.dart';
import 'package:my_family_mobile_app/views/components/common_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LinkToFamilyPage extends StatelessWidget {
  final RegisterController registerController = Get.find<RegisterController>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        title: Text('link_account'.tr),
        backgroundColor: AppColors.primary,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'link_account_title'.tr,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'link_account_description'.tr,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 40),
                Center(
                  child: Container(
                    width: Get.width * 0.8,
                    child: PinCodeTextField(
                      appContext: context,
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                        activeColor: AppColors.primary,
                        selectedColor: AppColors.primary,
                        inactiveColor: AppColors.greyColor,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      backgroundColor: Colors.transparent,
                      enableActiveFill: false,
                      controller: registerController.invitationCodeController,
                      onCompleted: (v) {
                        registerController.linkWithInvitationCode();
                      },
                      onChanged: (value) {
                        // nothing to do
                      },
                      beforeTextPaste: (text) {
                        return true;
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: CommonButton(
                    () => registerController.linkWithInvitationCode(),
                    'link_account_button'.tr,
                    Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () => registerController.skipLinking(),
                    child: Text(
                      'skip_linking'.tr,
                      style: TextStyle(
                        color: AppColors.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(() => registerController.isLinkingLoading.value
            ? Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                ),
              )
            : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
