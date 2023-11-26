import 'dart:async';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_video_call_agora/core/app_brain.dart';
import 'package:my_video_call_agora/features/single_video_call/single_call_button_controller.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({
    super.key,
  });

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {

  Timer? timer;
  var callListener;


  late RtcEngine _engine;

  int? _remoteUid;
  int _participantCount = 0;

  bool _localUserJoined = false;
  bool _isMicEnabled = false;
  bool _isCameraEnabled = false;

  @override
  void initState() {
    super.initState();
    _getPermissions();
    initAgora();
  }

  Future<void> _getMicPermissions() async {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      final micPermission = await Permission.microphone.request();
      if (micPermission == PermissionStatus.granted) {
        setState(() => _isMicEnabled = true);
      }
    } else {
      setState(() => _isMicEnabled = !_isMicEnabled);
    }
  }

  Future<void> _getCameraPermissions() async {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      final cameraPermission = await Permission.camera.request();
      if (cameraPermission == PermissionStatus.granted) {
        setState(() => _isCameraEnabled = true);
      }
    } else {
      setState(() => _isCameraEnabled = !_isCameraEnabled);
    }
  }

  Future<void> _getPermissions() async {
    await _getMicPermissions();
    await _getCameraPermissions();
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(
      RtcEngineContext(
        appId: AgoraManger.appId,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      ),
    );

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
            if (_participantCount <= 1) {
              setState(() {
                _participantCount++;
              });
            } else {
              // You can choose to reject additional participants here
              _engine.muteRemoteAudioStream(uid: remoteUid, mute: true);
              _engine.muteRemoteVideoStream(uid: remoteUid, mute: true);
            }

            /*if (widget.isSingleVideoCall == false) {
              _remoteUid = remoteUid;
              if (_participantCount < 6) {
                setState(() {
                  _participantCount++;
                });
              } else {
                // You can choose to reject additional participants here
                _engine.muteRemoteAudioStream(uid: remoteUid, mute: true);
                _engine.muteRemoteVideoStream(uid: remoteUid, mute: true);
              }
            } else {

            }*/
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = remoteUid;
            if (_participantCount == 0) {
              _localUserJoined = false;
            }
            _participantCount--;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    VideoEncoderConfiguration configuration = const VideoEncoderConfiguration();

    await _engine.enableVideo();
    await _engine.enableAudio();

    await _engine.startPreview();

    await _engine.joinChannel(
      token: AgoraManger.token,
      channelId: AgoraManger.channelName,
      uid: 0 ,
      options: const ChannelMediaOptions(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agora Video Call'),
      ),
      body: Stack(
        children: [
          Center(
            child: bigCamera(),
          ),
          smallCamera(),
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleCallButtonController(
              participantCount: _participantCount,
              remoteUid: _remoteUid,
              engine: _engine,
            ),
          ),
        ],
      ),
    );
  }

  Widget bigCamera() {
    if (_participantCount <= 1) {
      return _remoteVideo();
    } else {
      return const Text('the one you are calling is busy');
    }
  }

  Widget smallCamera() {
    if (_participantCount <= 1) {
      return Align(
        alignment: Alignment.topLeft,
        child: SizedBox(
          width: 100,
          height: 150,
          child: Center(
            child: _localUserJoined
                ? AgoraVideoView(
                    controller: VideoViewController(
                      rtcEngine: _engine,
                      canvas: const VideoCanvas(
                        uid: 0,
                      ),
                    ),
                  )
                : const CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(
            view: 0,
            uid: _remoteUid,
          ),
          connection: RtcConnection(
            channelId: AgoraManger.channelName,
          ),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}
