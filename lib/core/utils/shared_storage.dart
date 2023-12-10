import 'package:get_storage/get_storage.dart';

class SharedStorage {
  static String storageName = 'my_video_call_agora';
  static GetStorage box = GetStorage(storageName);
  static String tokenKey = 'userToken';
  static String userIdKey = 'userId';
  static String languageKey = 'language';
  static String firstTimeKey = 'firstTime';
  static String isNewUser = "isNewUser";
  static String isSeeIntroCard = "false";
  static String draftCounter = "draftCounter";
  static String? userType = "userType";

  static init() async {
    await GetStorage.init(storageName);
  }

  static hasToken() {
    if (box.hasData(tokenKey)) {
      return true;
    } else {
      return false;
    }
  }

  static getToken() {
    return box.read(tokenKey);
  }

  static writeToken(value) {
    box.write(tokenKey, value);
  }

  static removeToken() {
    box.remove(tokenKey);
  }

  static getLanguage() {
    return box.read(languageKey) ?? "en";
  }

  static writeLanguage(value) {
    box.write(languageKey, value);
  }

  static getUserType() {
    return box.read(userType!);
  }

  static writeUserType(value) {
    box.write(userType!, value);
  }

  static getFirstTime() {
    return box.read(firstTimeKey);
  }

  static writeFirstTime(value) {
    box.write(firstTimeKey, value);
  }

  static writeIsNewUser(isNew) {
    box.write(isNewUser, isNew);
  }

  static getUserId() {
    return box.read(userIdKey);
  }

  static writeUserId(value) {
    box.write(userIdKey, value);
  }

  static getDraftCounter() {
    return box.read(draftCounter) ?? 0;
  }

  static writeDraftCounter(value) {
    box.write(draftCounter, value);
  }

  static getIsNewUser() {
    if (box.hasData(isNewUser)) {
      return false;
    } else {
      return true;
    }
  }

  static writeisSawIntoCard(saw) {
    box.write(isSeeIntroCard, saw);
  }

  static getisSeeIntroCard() {
    if (box.hasData(isSeeIntroCard)) {
      return true;
    } else {
      return false;
    }
  }
}
