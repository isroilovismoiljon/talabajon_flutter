import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talabajon/core/utils/colors.dart';
import '../../../core/l10n/app_localizations.dart';

class PhotoToggleButtons extends StatelessWidget {
  final bool withPhoto;
  final void Function(bool value) togglePhoto;
  final MyLocalizations local;

  const PhotoToggleButtons({
    super.key,
    required this.withPhoto,
    required this.togglePhoto,
    required this.local,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390.w,
      height: 45.h,
      decoration: BoxDecoration(
        color: AppColors.indigoBlue,
        borderRadius: BorderRadius.circular(5.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => togglePhoto(false),
              icon: const Icon(Icons.image_not_supported_outlined),
              label: Text(local.no_photo),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(160.w, 35.h),
                backgroundColor:
                withPhoto ? AppColors.indigoBlue : AppColors.white,
                foregroundColor:
                withPhoto ? AppColors.white : AppColors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => togglePhoto(true),
              icon: const Icon(Icons.photo),
              label: Text(local.with_photo),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(160.w, 35.h),
                backgroundColor:
                withPhoto ? AppColors.white : AppColors.indigoBlue,
                foregroundColor:
                withPhoto ? AppColors.black : AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
