
import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:my_video_call_agora/core/constants/app_theme.dart';
import 'package:my_video_call_agora/features/spalsh/presentation/page/splash_page.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:my_video_call_agora/core/utils/shared_storage.dart';
import 'package:my_video_call_agora/features/auth/presentation/pages/register_page.dart';
import 'package:my_video_call_agora/features/notification/notification.dart';
import 'package:permission_handler/permission_handler.dart';

import 'core/bloc_observer.dart';
import 'core/constants/app_constants.dart';
import 'core/constants/app_settings.dart';
import 'core/widgets/easy_loading.dart';
import 'features/home/presentation/pages/home_screen.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  String? title = message.notification!.title;
  String? body = message.notification!.body;


  AwesomeNotificationSend.createNotification();

 /* AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 1,
      channelKey: 'call_channel',
      color: Colors.white,
      title: title,
      body: body,
      category: NotificationCategory.Call,
      timeoutAfter: const Duration(minutes: 1),
      wakeUpScreen: true,
      fullScreenIntent: true,
      autoDismissible: false,
      backgroundColor: Colors.orange,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'ACCEPT',
        label: 'Accept call',
        color: Colors.green,
        autoDismissible: true,
        //actionType: ActionType.SilentAction,
      ),
      NotificationActionButton(
        key: 'REJECT',
        label: 'Reject call',
        color: Colors.red,
        autoDismissible: true,
        actionType: ActionType.DisabledAction,
      ),
    ],
  );*/
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedStorage.init();

  AwesomeNotificationSend.createNotification();

  Permission.systemAlertWindow;
  await Permission.notification.request();

  AwesomeNotificationSend.notificationInitialize();

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  Bloc.observer = MyBlocObserver();

  Messaging.initFCM();
  timeago.setLocaleMessages('ar', timeago.ArMessages());
  timeago.setLocaleMessages('en', timeago.EnMessages());
  await SharedStorage.init();

  runApp(EasyLocalization(
    supportedLocales: AppConstant.languages.values.toList(),
    path: 'assets/locales',
    fallbackLocale: const Locale('en'),
    startLocale: Locale(SharedStorage.getLanguage()),
    saveLocale: true,
    child: Phoenix(child: const MyApp()),
  ),);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
///TODO need to review
  StreamSubscription? _streamSubscription;

  @override
  void dispose() {
    // TODO: implement dispose
    _streamSubscription?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    EasyLoadingClass.getStyleEasyLoading();

    return Theme(
      data: AppTheme.appTheme,
      child: PlatformProvider(
        settings: PlatformSettingsData(iosUsesMaterialWidgets: true),
        builder: (context) => PlatformApp(
          navigatorKey: Keys.navigatorKey,
          localizationsDelegates: [
            ...context.localizationDelegates,
            SfGlobalLocalizations.delegate
          ],
          supportedLocales: AppConstant.languages.values.toList(),
          builder: EasyLoading.init(),
          locale: context.locale,
          title: AppSettings.appName,
          home: Splash(navigator: _getNextPage()),
          material: (_, __) => MaterialAppData(
              scrollBehavior: AppScrollBehavior(),
              theme: AppTheme.appTheme,
              debugShowCheckedModeBanner: AppSettings.isDebug,),
          cupertino: (_, __) => CupertinoAppData(
            scrollBehavior: AppScrollBehavior(),
            theme: AppTheme.appThemeCupertino,
            debugShowCheckedModeBanner: AppSettings.isDebug,
          ),
        ),
      ),
    );
  }

  _getNextPage() {
  if (SharedStorage.hasToken()) {
      return const HomeScreen();
    } else {
      return Register();
    }
  }
}

