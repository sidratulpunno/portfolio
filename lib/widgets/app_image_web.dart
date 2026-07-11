// ignore_for_file: deprecated_member_use, avoid_web_libraries_in_flutter

import 'dart:html' as html;
import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';

class AppImageImpl extends StatefulWidget {
  final String src;
  final BoxFit fit;
  final double? width;
  final double? height;

  const AppImageImpl({super.key, required this.src, this.fit = BoxFit.contain, this.width, this.height});

  @override
  State<AppImageImpl> createState() => _AppImageImplState();
}

class _AppImageImplState extends State<AppImageImpl> {
  static int _counter = 0;
  String _viewType = '';
  final html.DivElement _div = html.DivElement();
  final html.ImageElement _img = html.ImageElement();
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _img.style
      ..width = '100%'
      ..height = '100%'
      ..objectFit = 'contain'
      ..borderRadius = '10px';
    _img.onLoad.listen((_) {
      if (mounted) setState(() => _loaded = true);
    });
    _img.src = widget.src;
    _div.style
      ..width = '100%'
      ..height = '100%'
      ..borderRadius = '10px'
      ..overflow = 'hidden';
    _div.append(_img);
    _viewType = 'web-image-${_counter++}';
    ui_web.platformViewRegistry.registerViewFactory(_viewType, (int viewId) => _div);
  }

  @override
  void didUpdateWidget(AppImageImpl old) {
    super.didUpdateWidget(old);
    if (old.src != widget.src) {
      _loaded = false;
      _img.src = widget.src;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return Container(
        width: widget.width,
        height: widget.height,
        color: const Color(0xFF1A1A2E),
        child: const Center(
          child: SizedBox(
            width: 20, height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: HtmlElementView(viewType: _viewType),
    );
  }
}
