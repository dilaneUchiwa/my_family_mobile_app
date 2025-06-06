import 'package:get/get.dart';
import 'package:my_family_mobile_app/routes/appRoutes.dart';
import 'package:my_family_mobile_app/views/pages/MainPage.dart';
import 'package:my_family_mobile_app/views/pages/homePage.dart';
import 'package:my_family_mobile_app/views/pages/linkToFamilyPage.dart';
import 'package:my_family_mobile_app/views/pages/loginPage.dart';
import 'package:my_family_mobile_app/views/pages/registerPage.dart';
import 'package:my_family_mobile_app/views/pages/space/eventDetailsPage.dart';
import 'package:my_family_mobile_app/views/pages/splashScreen.dart';
import 'package:my_family_mobile_app/views/pages/space/spacePage.dart';
import 'package:my_family_mobile_app/views/pages/space/spaceDetailsPage.dart';
import 'package:my_family_mobile_app/views/pages/space/discussionPage.dart';
import 'package:my_family_mobile_app/views/pages/space/eventPage.dart';
import 'package:my_family_mobile_app/views/pages/space/messagePage.dart';
import 'package:my_family_mobile_app/views/pages/space/selectMembersPage.dart';
import 'package:my_family_mobile_app/views/pages/space/createSpacePage.dart';
import 'package:my_family_mobile_app/views/pages/space/mediaGalleryPage.dart';
import 'package:my_family_mobile_app/views/pages/space/spaceMembersPage.dart';
import 'package:my_family_mobile_app/views/pages/space/spaceSettingsPage.dart';
import 'package:my_family_mobile_app/views/pages/space/createEventPage.dart';
import 'package:my_family_mobile_app/views/pages/space/mediaUploadPage.dart';

class AppRouter {
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => Mainpage(),
      // binding: HomeBinding(),
    ),
    GetPage(name: AppRoutes.splash, page: () => SplashScreen()),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage()
    ),
    GetPage(name: AppRoutes.register, page: ()=> RegisterPage() ),
    GetPage(name: AppRoutes.link_to_invite, page: () => LinkToFamilyPage() ),
    GetPage(name: AppRoutes.space, page: () => SpacePage()),
    GetPage(name: AppRoutes.spaceDetails, page: () => SpaceDetailsPage()),
    GetPage(name: AppRoutes.spaceDiscussions, page: () => DiscussionPage()),
    GetPage(name: AppRoutes.spaceEvents, page: () => EventPage()),
    GetPage(name: AppRoutes.discussionMessages, page: () => MessagePage()),
    
    // Space related routes
    GetPage(name: AppRoutes.spaceCreate, page: () => CreateSpacePage()),
    GetPage(name: AppRoutes.spaceMembers, page: () => SpaceMembersPage()),
    GetPage(name: AppRoutes.spaceSettings, page: () => SpaceSettingsPage()),
    GetPage(name: AppRoutes.spaceMedia, page: () => MediaGalleryPage()),
    GetPage(name: AppRoutes.discussionSelectMembers, page: () => SelectMembersPage()),
    GetPage(name: AppRoutes.eventCreate, page: () => CreateEventPage()),
    GetPage(name: AppRoutes.eventDetails, page: () => EventDetailsPage()),
    GetPage(name: AppRoutes.spaceMediaUpload, page: () => MediaUploadPage()),
  ];
}
