
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fcm/flutter_fcm.dart';
import 'package:my_video_call_agora/core/firebase_options.dart';
import 'package:my_video_call_agora/features/notification/repository/sendNotificationConsole.dart';
import 'package:my_video_call_agora/features/home/presentation/pages/home_screen.dart';

class AwesomeNotificationSend {
  static Future<void> startListeningNotificationEvents(
    BuildContext context,
  ) async {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: (ReceivedAction receivedAction) async {
      if (receivedAction.buttonKeyPressed == 'ACCEPT') {
        SendNotificationConsole.sendPushNotification(false);

        print('aaaaaaaaaaaaaaaa');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const HomeScreen();
            },
          ),
        );
      } else  if (receivedAction.buttonKeyPressed == 'REJECT'){
        print('llllllllllllllll');
        SendNotificationConsole.sendPushNotification(false);

      }
    });
  }

  /*static Future<void> sendReceiveNotification() async {
    var serverKey =
        'AAAAEEcNRK8:APA91bFsczWw0NgJMVrujtfjeLmMucAL_HGTcUexcxthlvdhWckPODrclYsjAVM6gWVMDCbxr03C_AzZfyLRhHgdMx_axMtlMxJEP3Z1K2I2RhwZ4MBDem34mcD2u4IXvnSTA55mrVZb';

    var fcmUrl = 'https://fcm.googleapis.com/fcm/send';

    ///TODO my mobile
*//*    var to =
        "eObPhrUVRSSZfGrry0e8iV:APA91bGX7vblAjuzE7oo9owC8dyUgWougX_jhne5YX8FQqYqJLEl3wgmsNLXFv9d-dfbGz9sWKCdaZ8syQtlqM6js-fUTKQ4qhGmF5wFdcmlse4hAiMWNanv6jqnS_LrC-nInOeTqYQ4";
 *//*   ///TODO emulator
    var to =
        "euLK0Y0cS82xJZet4f1RfZ:APA91bFwt4rp_M5G2nlCJE_gtTq5tarGdGDl3-na5HoPWuCUsu4yFPshM6scfPDls6OvZa_Zi-8dDOZrSflThrfxsuPFjYLRGCmeDjthYK2VBIQd5R7iAaBJcZljv86aOfErvW_GCfxy";
    Map<String, dynamic>? date = {
      'to': to,
      'notification': <String, dynamic>{
        'body': 'hani',
        'title': 'send back from phone',
      },
      'priority': 'high',
      'data': <String, dynamic>{
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'id': '1',
        'status': 'done',
      }
    };
    print(date);
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'key=$serverKey',
    };

    print(headers);

    try {
      http.Response response = await http.post(
        Uri.parse(fcmUrl),
        headers: headers,
        body: jsonEncode(date),
      );
      response;
      if (response.statusCode == 200) {
        print('Notification sentBack successfully');
      } else {
        print('Failed to send notification. Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Failed to sendBack notification. Error: $e');
    }
  }*/



  static createNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

      String? title = message.notification!.title;
      String? body = message.notification!.body;

      AwesomeNotifications().createNotification(
        schedule: NotificationAndroidCrontab.minutely(
          referenceDateTime: DateTime.now(),
        ),
        content: NotificationContent(
          id: 123456789,
          channelKey: 'call_channel',
          color: Colors.white,
          title: title,
          body: body,
          category: NotificationCategory.Call,
          timeoutAfter: const Duration(minutes: 1),
          wakeUpScreen: true,
          autoDismissible: false,
          backgroundColor: Colors.red,
        ),
        actionButtons: [
          NotificationActionButton(
          key: 'REJECT',
          label: 'Reject call',
          color: Colors.red,
          autoDismissible: true,
        ),
          NotificationActionButton(
            key: 'ACCEPT',
            label: 'Accept call',
            color: Colors.green,
            autoDismissible: true,
          ),

        ],
      );
    });
  }

  static notificationInitialize() {

    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    AwesomeNotifications().checkPermissionList(permissions: [
      NotificationPermission.Alert,
      NotificationPermission.Sound,
      NotificationPermission.Vibration,
      NotificationPermission.Light
    ]);

    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'call_channel',
          channelName: 'call channel',
          channelDescription: 'channel of calling',
          defaultColor: Colors.red,
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          locked: true,
          defaultRingtoneType: DefaultRingtoneType.Ringtone,
        ),
      ],
    );
  }
}

class Messaging {
  static String? token;

  static Future<void> onNotificationReceived(RemoteMessage message) async {
    print('Handling a message ${message.messageId}');
  }

  static initFCM() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("jjjjjjjjjjjjjjjjj");
    print(Messaging.token);
    print("jjjjjjjjjjjjjjjjj");

    try {
      await FCM.initializeFCM(
        onNotificationReceived: onNotificationReceived,
        withLocalNotification: true,
        onNotificationPressed: (Map<String?, dynamic>? data) {
          print('kkkkkkkkkkkkkkkkkkkkkkk');
          // Notifications notification = Notifications.fromFCM(data);
          // NotificationMiddleware.forward(notification);
        },
        onTokenChanged: (String? token) {
          Messaging.token = token;
/* if (SharedStorage.hasToken()) {
            NotificationRepository.uploadNotificationsToken(Messaging.token);
          }*/

          print("token");
          print(token);
        },
        // TODO add this icon to android/app/src/main/res/drawable/ic_launcher.png
        icon: 'ic_launcher',
/*navigatorKey: Keys.navigatorKey,*/
      );
    } catch (e) {
      print("eeeeeeeeeeeeeeeeee");
      print(e);
    }
  }
}
