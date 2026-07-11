import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/colors.dart';

class AppImageImpl extends StatelessWidget {
  final String src;
  final BoxFit fit;
  final double? width;
  final double? height;

  const AppImageImpl({super.key, required this.src, this.fit = BoxFit.contain, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return CachedNetworkImage(
      imageUrl: src,
      fit: fit,
      width: width,
      height: height,
      placeholder: (_, _) => Container(
        color: dark ? PortfolioColors.cardDark : PortfolioColors.borderLight,
        child: Center(
          child: SizedBox(
            width: 20, height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: PortfolioColors.accent.withValues(alpha: 0.5),
            ),
          ),
        ),
      ),
      errorWidget: (_, _, _) => Container(
        color: dark ? PortfolioColors.cardDark : PortfolioColors.borderLight,
        child: Center(
          child: Icon(Icons.image_outlined, color: PortfolioColors.textTertiaryDark.withValues(alpha: 0.5), size: 28),
        ),
      ),
    );
  }
}
