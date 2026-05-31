import 'dart:html' as html;
import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';

class SafeImage extends StatelessWidget {
  final String src;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget Function(BuildContext, Widget, ImageChunkEvent?)? loadingBuilder;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  const SafeImage({
    super.key,
    required this.src,
    this.fit = BoxFit.contain,
    this.width,
    this.height,
    this.loadingBuilder,
    this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final viewType = 'si-${src.hashCode}';
    try {
      ui_web.platformViewRegistry.registerViewFactory(
        viewType,
        (int viewId) => html.ImageElement()
          ..src = src
          ..style.width = '100%'
          ..style.height = '100%'
          ..style.setProperty('object-fit', _fitCss()),
      );
    } catch (_) {}
    return SizedBox(
      width: width,
      height: height,
      child: HtmlElementView(viewType: viewType),
    );
  }

  String _fitCss() {
    switch (fit) {
      case BoxFit.cover:
        return 'cover';
      case BoxFit.fill:
        return 'fill';
      case BoxFit.none:
        return 'none';
      case BoxFit.scaleDown:
        return 'scale-down';
      default:
        return 'contain';
    }
  }
}
