import 'package:agora_uikit/agora_uikit.dart';

import 'package:flutter/material.dart';
import 'package:my_video_call_agora/core/app_brain.dart';

class MultipleVideoCall extends StatefulWidget {
  const MultipleVideoCall({super.key});

  @override
  State<MultipleVideoCall> createState() => _MultipleVideoCallState();
}

class _MultipleVideoCallState extends State<MultipleVideoCall> {
  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: AgoraManger.appId,
      channelName: AgoraManger.channelName,
      tempToken: AgoraManger.token,
      uid: 0
    ),

    agoraChannelData: AgoraChannelData(),
  );

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  void initAgora() async {
    await client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            AgoraVideoViewer(
              showNumberOfUsers: true,
              client: client,
              layoutType: Layout.floating,
              enableHostControls: true, // Add this to enable host controls
            ),
            AgoraVideoButtons(
              client: client,
              addScreenSharing: false, // Add this to enable screen sharing
            ),
          ],
        ),
      ),
    );
  }
}
