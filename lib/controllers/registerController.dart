import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_family_mobile_app/controllers/toastController.dart';
import 'package:my_family_mobile_app/routes/appRoutes.dart';
import 'package:my_family_mobile_app/services/authService.dart';
import 'package:my_family_mobile_app/services/nodeService.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;
  var isLinkingLoading = false.obs;
  final usernameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  final titleTextController = TextEditingController();
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final birthDateTextController = TextEditingController();
  final addressTextController = TextEditingController();
  final phoneTextController = TextEditingController();

  final invitationCodeController = TextEditingController();

  var selectedGender = 'MALE'.obs;
  var selectedInterests = <String>[].obs;
  var birthDate = DateTime.now().obs;

  final List<String> titles = ['Mr', 'Mrs', 'Ms', 'Dr'];
  final List<String> genders = ['MALE', 'FEMALE', 'OTHER'];
  final List<String> availableInterests = [
    'Family History',
    'Genealogy',
    'Photography',
    'Story Telling',
    'Research',
    'History'
  ];

  void updateBirthDate(DateTime date) {
    birthDate.value = date;
    birthDateTextController.text = DateFormat('yyyy-MM-dd').format(date);
  }

  void toggleInterest(String interest) {
    if (selectedInterests.contains(interest)) {
      selectedInterests.remove(interest);
    } else {
      selectedInterests.add(interest);
    }
  }

  void register() async {
    if (passwordTextController.text != confirmPasswordTextController.text) {
      ToastController(
        title: 'Error',
        message: 'passwords_dont_match'.tr,
        type: ToastType.error
      ).showToast();
      return;
    }

    final userData = {
      "title": titleTextController.text,
      "firstName": firstNameTextController.text,
      "lastName": lastNameTextController.text,
      "email": emailTextController.text,
      "username": usernameTextController.text,
      "password": passwordTextController.text,
      "birthDate": birthDateTextController.text,
      "gender": selectedGender.value,
      "address": addressTextController.text,
      "phone": phoneTextController.text,
      "interests": selectedInterests,
    };

    isLoading.value = true;

    Get.offAllNamed(AppRoutes.link_to_invite);

    final isRegister = await AuthService.register(userData);

    if(isRegister){
      ToastController(
        title: 'Success',
        message: 'registration_successful'.tr,
        type: ToastType.success
      ).showToast();
      Get.offAllNamed(AppRoutes.link_to_invite);
    } 
    isLoading.value = false;
  }

  Future<void> linkWithInvitationCode() async {
    if (invitationCodeController.text.length != 6) {
      ToastController(
        title: 'Error',
        message: 'invalid_invitation_code'.tr,
        type: ToastType.error
      ).showToast();
      return;
    }

    isLinkingLoading.value = true;
    
    try {
      final result = await NodeService.useInvitation(invitationCodeController.text);
      
      if (result != null) {
        ToastController(
          title: 'Success',
          message: 'account_linked_successfully'.tr,
          type: ToastType.success
        ).showToast();
        Get.offAllNamed(AppRoutes.home);
      } 
    } finally {
      isLinkingLoading.value = false;
    }
  }

  void skipLinking() {
    Get.offAllNamed(AppRoutes.home);
  }

  @override
  void onClose() {
    usernameTextController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    confirmPasswordTextController.dispose();
    titleTextController.dispose();
    firstNameTextController.dispose();
    lastNameTextController.dispose();
    birthDateTextController.dispose();
    addressTextController.dispose();
    phoneTextController.dispose();
    // invitationCodeController.dispose();
    super.onClose();
  }
}