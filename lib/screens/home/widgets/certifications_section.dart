import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../../../data/resume_data.dart';
import '../../../widgets/animated_section.dart';
import '../../../widgets/section_header.dart';
import '../../../widgets/credential_card.dart';

class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final pad = AppTheme.paddingScreenWide(context);
    final cols = AppTheme.gridColumns(context);

    return Container(
      color: Theme.of(context).brightness == Brightness.dark
          ? null
          : null,
      padding: EdgeInsets.symmetric(horizontal: pad.horizontal, vertical: AppTheme.sectionSpacing(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedSection(
            child: const SectionHeader(
              title: 'Certifications',
              subtitle: 'Professional certifications and credentials',
            ),
          ),
          const SizedBox(height: 32),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              mainAxisExtent: 280,
            ),
            itemCount: ResumeData.certifications.length,
            itemBuilder: (_, i) => AnimatedSection(
              delayMs: i * 60,
              child: CredentialCard(
                title: ResumeData.certifications[i].title,
                imageUrl: ResumeData.certifications[i].imageUrl,
                verifyUrl: ResumeData.certifications[i].verifyUrl,
                verifyLabel: 'Verify Certificate',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
