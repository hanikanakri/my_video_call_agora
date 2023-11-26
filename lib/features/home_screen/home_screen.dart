
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:my_video_call_agora/features/notification/sendNotificationConsole.dart';

import '../notification/notification.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    AwesomeNotificationSend.createNotification();

    AwesomeNotificationSend.startListeningNotificationEvents(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      String? token =
                          await FirebaseMessaging.instance.getToken();
                      print(token);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Text('get token'),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      SendNotificationConsole.sendPushNotification(true);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Text('push notification'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



