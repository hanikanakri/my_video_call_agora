import 'package:flutter/material.dart';

class DeviceInfo{
  static Size? _size;
  static double? _width;
  static double? _height;

  static double get width => _width!;
  static double get height => _height!;
  static Size get size => _size!;

  DeviceInfo(BuildContext context){
    _size = MediaQuery.of(context).size;
    _width = size.width;
    _height = size.height;
  }
}