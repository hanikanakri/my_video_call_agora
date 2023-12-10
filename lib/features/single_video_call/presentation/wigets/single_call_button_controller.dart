// ignore_for_file: must_be_immutable

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

class SingleCallButtonController extends StatefulWidget {
  SingleCallButtonController({
    super.key,
    this.participantCount,
    this.remoteUid,
    this.engine,
  });

  int? participantCount;
  int? remoteUid;

  late RtcEngine? engine;
  @override
  State<SingleCallButtonController> createState() =>
      _SingleCallButtonControllerState();
}

class _SingleCallButtonControllerState
    extends State<SingleCallButtonController> {

  bool closeVideo = true;
  bool closeAudio = true;
  bool closeSpeaker = true;

  void switchCamera() async {
    await widget.engine!.switchCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 20,),
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await widget.engine!.disableAudio();
              await widget.engine!.disableVideo();
            },
            icon: const Icon(
              Icons.call_end,
              color: Colors.red,
            ),
          ),
          Visibility(
            visible: widget.remoteUid != null && widget.participantCount! <= 1,
            child: IconButton(
              onPressed: () {
                switchCamera();
              },
              icon: const Icon(
                Icons.switch_camera,
                color: Colors.red,
              ),
            ),
          ),
          Visibility(
            visible: widget.remoteUid != null && widget.participantCount! <= 1,
            child: CircleAvatar(
              backgroundColor: closeAudio ? Colors.transparent : Colors.blue,
              child: IconButton(
                onPressed: () async {
                  await widget.engine!.muteLocalAudioStream(closeAudio);
                  setState(() {
                    closeAudio = !closeAudio;
                  });
                },
                icon: Icon(
                  closeAudio ? Icons.audiotrack_rounded : Icons.music_off,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          Visibility(
            visible: widget.remoteUid != null && widget.participantCount! <= 1,
            child: CircleAvatar(
              backgroundColor: closeVideo ? Colors.transparent : Colors.blue,
              child: IconButton(
                onPressed: () async {
                  await widget.engine!.muteLocalVideoStream(closeVideo);
                  setState(() {
                    closeVideo = !closeVideo;
                  });
                },
                icon: Icon(
                  closeVideo ? Icons.videocam : Icons.videocam_off,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          Visibility(
            visible: widget.remoteUid != null && widget.participantCount! <= 1,
            child: CircleAvatar(
              backgroundColor: closeSpeaker ? Colors.transparent : Colors.blue,
              child: IconButton(
                onPressed: () async {
                  await widget.engine!.setEnableSpeakerphone(closeSpeaker);
                  setState(() {
                    closeSpeaker = !closeSpeaker;
                  });
                },
                icon: Icon(
                  closeSpeaker ? Icons.volume_up : Icons.volume_off,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
