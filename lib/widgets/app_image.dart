import 'package:flutter/material.dart';
import 'app_image_stub.dart' if (dart.library.html) 'app_image_web.dart';

class AppImage extends StatelessWidget {
  final String src;
  final BoxFit fit;
  final double? width;
  final double? height;

  const AppImage({
    super.key,
    required this.src,
    this.fit = BoxFit.contain,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return AppImageImpl(src: src, fit: fit, width: width, height: height);
  }
}
