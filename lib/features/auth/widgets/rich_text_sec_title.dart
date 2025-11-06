import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:talabajon/core/utils/styles.dart';

import '../../../core/utils/colors.dart';

class RichTextSecTitle extends StatelessWidget {
  const RichTextSecTitle({
    super.key,
    required this.title1,
    required this.title2,
    this.onPressed = _defaultOnPressed,
  });

  final String title1, title2;
  final VoidCallback onPressed;

  static void _defaultOnPressed() {}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          style: AppStyles.w400s12,
          children: [
            TextSpan(
              text: title1,
            ),
            TextSpan(
              text: title2,
              style: AppStyles.w500s12.copyWith(color: AppColors.indigoBlue),
              recognizer: TapGestureRecognizer()..onTap = onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
