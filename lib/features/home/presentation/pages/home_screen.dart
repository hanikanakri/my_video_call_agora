import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_video_call_agora/core/animations/navigation_route_animation/navigation_route_animation.dart';
import 'package:my_video_call_agora/core/database/db/sqflite.dart';
import 'package:my_video_call_agora/features/audio_call/presentation/pages/audio_call.dart';
import 'package:my_video_call_agora/features/group_video_call/presentation/pages/multiple_video_call.dart';
import 'package:my_video_call_agora/features/single_video_call/presentation/pages/video_call.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/database/image_db/image_db.dart';
import '../../../../core/utils/navigation.dart';
import '../widgets/general_home_scaffold.dart';
import 'maps.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SqfliteDataBase sqfliteDataBase = SqfliteDataBase();
  Int8List? _types;

  List<Map> snapshotData = [];
  bool isLoading = true;

  String? imageURL;

  _getBytes(imageURL) async {
    final ByteData data =
        await NetworkAssetBundle(Uri.parse(imageURL)).load(imageURL);
    _types = data.buffer.asInt8List();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // readData();
    _fetchData();
    _getBytes(imageURL);
  }

  bool location =true;


  @override
  Widget build(BuildContext context) {
    return GeneralHomeScaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "${snapshotData[0]['fullName'] ?? ''}",
                  style: AppTheme.headline.copyWith(
                    color: AppColors.white,
                    fontSize: 20,
                  ),
                ),
                const ImageStorage(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "${snapshotData[0]['emailAddress'] ?? ''}",
                      style: AppTheme.bodySmall.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                      "${snapshotData[0]['phoneNumber'] ?? ''}",
                      style: AppTheme.bodySmall.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MakeCall(
                        onPressed: () {
                          Navigation.push(context, const VideoCallScreen());
                        },
                        icon: Icons.video_call,
                        name: '',
                      ),
                      MakeCall(
                        onPressed: () {
                          Navigation.push(
                            context,
                            const MultipleVideoCall(),
                          );
                        },
                        icon: Icons.video_call,
                        name: '',
                      ),
                      MakeCall(
                        onPressed: () {
                          Navigation.push(
                            context,
                            const AudioCallScreen(),
                          );
                        },
                        icon: Icons.phone,
                        name: '',
                      ),
                      MakeCall(
                        onPressed: () {
                          AnimationNavigation.slidePush(
                            context,
                            const GoogleMaps(),
                          );
                        },
                        icon: Icons.map_outlined,
                        name: '',
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Future readData() async {
    List<Map> response =
        await sqfliteDataBase.readDatabase("SELECT * FROM tasks");

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
    return response;
  }

  Future<void> _fetchData() async {
    List<Map> response = await readData();
    setState(() {
      snapshotData = response;
    });
  }
}

class MakeCall extends StatelessWidget {
  final String? name;
  final IconData? icon;
  final VoidCallback? onPressed;

  const MakeCall({
    super.key,
    this.name,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.red,
            radius: 30.0,
            child: Icon(
              icon,
              color: AppColors.teal,
              size: 30,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            name!.tr(),
            style: AppTheme.bodySmall.copyWith(
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
