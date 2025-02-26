import 'package:get/get.dart';
import 'package:popgame/core/settings/enums.dart';

class AppSystemValues extends GetxController {
  final Rx<SupportedLanguages> activeAppLanguage = SupportedLanguages.turkish.obs;
}
