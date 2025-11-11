import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:talabajon/core/utils/svgs.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/utils/styles.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({
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
    final local = MyLocalizations.of(context)!;
    return AlertDialog(
      title: Center(
        child: Column(
          children: [
            SvgPicture.asset(AppSvgs.warning),
            Text("$title1?", style: AppStyles.w600s20),
          ],
        ),
      ),
      content: Text(title2),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => context.pop(),
              child: Text(local.no),
            ),
            GestureDetector(
              onTap: onPressed,
              child: Text(local.ok),
            ),
          ],
        ),
      ],
    );
  }
}
