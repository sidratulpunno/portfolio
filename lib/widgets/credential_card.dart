import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../utils/launch.dart';
import 'app_image.dart';
import 'hover_card.dart';

class CredentialCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String verifyUrl;
  final String verifyLabel;

  const CredentialCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.verifyUrl,
    this.verifyLabel = 'Verify',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return HoverCard(
      radius: 16,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(fontSize: 12),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AppImage(
                src: imageUrl,
                fit: BoxFit.contain,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => launchUrlExternal(verifyUrl),
              icon: const Icon(Icons.verified, size: 14),
              label: Text(verifyLabel),
              style: OutlinedButton.styleFrom(
                foregroundColor: PortfolioColors.accent,
                side: BorderSide(
                  color: PortfolioColors.accent.withValues(alpha: 0.5),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                textStyle: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
