
import 'package:flutter/material.dart';
import 'package:my_video_call_agora/core/constants/app_assets.dart';

class NullableImage {
  static Image build({
    required final String? image,
    final bool network = true,
    final String placeholder = AppAssets.logoURI,
    final BoxFit fit = BoxFit.cover,
  }) {
    if (image == null) {
      return Image.asset(
        placeholder,
        fit: fit,

      );
    }
    if (network) {
      return Image.network(
        image,
        fit: fit,
        errorBuilder: (_, __, ___) {
          return Image.asset(
            placeholder,
            fit: fit,
          );
        },
      );
    }
    return Image.asset(
      image,
      fit: fit,
    );
  }
}
