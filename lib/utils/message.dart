import 'package:get/get.dart';
import 'package:my_family_mobile_app/utils/translations/fr.dart';
import 'package:my_family_mobile_app/utils/translations/en.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys =>
      {'en_US': en, 'fr_FR': fr};
}
