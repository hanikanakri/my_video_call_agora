import '../utils/shared_storage.dart';

class AppAssets {
  AppAssets._();

  static const String baseDbURI = 'assets/images/db/';
  static const String personDbURI = '${baseDbURI}person_image.jpg';

  static const String baseAssetsURI = 'assets/images/';
  static const String mainBackground = '${baseAssetsURI}main_background.png';
  static const String noData = '${baseAssetsURI}no_data.png';
  static const String errorData = '${baseAssetsURI}error.png';

//logo
  static const String baseLogoURI = '${baseAssetsURI}logo/';
  static const String logoURI = '${baseLogoURI}app_icon.png';

  static String get appName => SharedStorage.getLanguage() == "ar"
      ? "${baseLogoURI}app_name_ar.svg"
      : "${baseLogoURI}app_name_en.svg";

  static String get appNameGeneral => SharedStorage.getLanguage() == "ar"
      ? "${baseLogoURI}app_name_general_ar.svg"
      : "${baseLogoURI}app_name_general_en.svg";

  /*static String get splashLogo => SharedStorage.getLanguage() == "ar"
      ? baseLogoURI + "splash_logo_ar.png"
      : baseLogoURI + "splash_logo_en.png";*/
  static String splashLogo = "${baseLogoURI}splash_logo.gif";

  //splash
  static const String baseSplashURI = '${baseAssetsURI}splash/';

  static const String splashBackGroundImageURI =
      '${baseSplashURI}splash_background.jpg';

  static const String baseForgetPasswordURI =
      '${baseAssetsURI}forget_password/';
  static const String emojiHappyURI = '${baseForgetPasswordURI}emoji_happy.svg';
  static const String emojiLaughsURI =
      '${baseForgetPasswordURI}emoji_laughs.svg';
  static const String emojiSadURI = '${baseForgetPasswordURI}emoji_sad.svg';

  //auth assets
  static const String baseAuthURI = '${baseAssetsURI}auth/';

  static const String changeLanguageURI = '${baseAuthURI}changeLanguage.svg';

  //final auth
  static const String loginIcon = '${baseAuthURI}login_icon.svg';
  static const String registrationNewAccount =
      '${baseAuthURI}registeration_new_account.svg';
  static const String verifyCode = '${baseAuthURI}verify_code.svg';

  //Home  asset
  static const String baseHomeURI = '${baseAssetsURI}home/';
  static const String appBackgroundURI = '${baseHomeURI}app_background_1.png';
  static const String appBackground1URI = '${baseHomeURI}app_background_2.png';
  static const String personURI = '${baseHomeURI}person.png';
  static const String cartonBox = '${baseHomeURI}box.png';
  static const String homePageBoxCardURI =
      '${baseHomeURI}home_page_box_card1.png';

  static const String homePageBackGroundImageURI =
      '${baseHomeURI}home_page_background_image1.jpg';

  /*static const String homePageBackGroundImageURI =
      baseHomeURI + 'home_page_backGraound_image.svg';*/

  //request  asset
  static const String baseRequestURI = '${baseAssetsURI}request/';
  static const String cameraIcon = '${baseRequestURI}camera.svg';
  static const String galleryIcon = '${baseRequestURI}gallery.svg';
  static const String uploadImageIcon = '${baseRequestURI}uploadImage.svg';
  static const String saveTempIcon = '${baseRequestURI}saveTemp.svg';
}
