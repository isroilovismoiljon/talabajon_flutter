import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talabajon/features/service/widgets/custom_empty_field.dart';
import '../../../core/l10n/app_localizations.dart';

class InputFieldsSection extends StatelessWidget {
  final TextEditingController themeController;
  final TextEditingController authorController;
  final MyLocalizations local;

  const InputFieldsSection({
    super.key,
    required this.themeController,
    required this.authorController,
    required this.local,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.h,
      children: [
        CustomEmptyField(
          controller: themeController,
          titleHint: local.theme,
          maxLines: 2,
        ),
        CustomEmptyField(
          controller: authorController,
          titleHint: local.author,
        ),
      ],
    );
  }
}
