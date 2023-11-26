import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/utils/shared_storage.dart';

class SendNotificationConsole {
  static Future<void> sendPushNotification(bool from) async {
    var serverKey =
        'AAAAEEcNRK8:APA91bFsczWw0NgJMVrujtfjeLmMucAL_HGTcUexcxthlvdhWckPODrclYsjAVM6gWVMDCbxr03C_AzZfyLRhHgdMx_axMtlMxJEP3Z1K2I2RhwZ4MBDem34mcD2u4IXvnSTA55mrVZb';

    var fcmUrl = 'https://fcm.googleapis.com/fcm/send';

    ///TODO my mobile
    var to =
        "clVOyxl7QJKtzmPK03S_9K:APA91bFjUZfcSVbiqhLiubP8OYcFXhCN6DNq1esC8spxDGfr7BaLH_XrHhlT3cN0nEggwtD23E_XmBcNsrMGw57540pKhdPKs8LsMvzFTHOiP2CZUdoLMAJHZo9nCwWNS9I7yAJ5l3Qx";

    ///TODO emulator
    /*var to =
        "eFd57GeuSJuHtiB8YWyFro:APA91bFH820mi2WoNoqiyPw9-GeiHyME1PhbHCjnQyTiVDnT96AcRtcDaHB4Qx9vXd8S26A0j8B2wuez_zypc9aZvDtdVw7C__x_ylMzWjOGydPMgOYtUw7L7R-VvHVYKOjQylkNYQqq";
    */
    Map<String, dynamic>? date = {
      'to': SharedStorage.getToken(),
      'notification': <String, dynamic>{
        'body': 'hani',
        'title': 'Incoming Call from phone',
      },
      'priority': 'high',
      'data': <String, dynamic>{
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'id': '1',
        'status': 'done',
      }
    };
    Map<String, dynamic>? dateback = {
      'to': SharedStorage.getToken(),
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
    print(from ? date : dateback);
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'key=$serverKey',
    };

    print(headers);

    try {
      http.Response response = await http.post(
        Uri.parse(fcmUrl),
        headers: headers,
        body: jsonEncode(from ? date : dateback),
      );
      response;
      if (from) {
        if (response.statusCode == 200) {
          print('Notification sent successfully');
        } else {
          print('Failed to send notification. Error: ${response.reasonPhrase}');
        }
      } else {
        if (response.statusCode == 200) {
          print('Notification sent back successfully');
        } else {
          print(
              'Failed to send back notification. Error: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      print('Failed to send notification. Error: $e');
    }
  }
}