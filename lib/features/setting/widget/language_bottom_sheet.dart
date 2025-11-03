import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/utils/svgs.dart';
import '../../common/managers/localizatoin_cubit.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  late String tanlanganTil;

  @override
  void initState() {
    super.initState();
    final locale = context.read<LocalizationCubit>().currentLocale;
    if (locale == "uz") {
      tanlanganTil = "O‘zbekcha";
    } else if (locale == "ru") {
      tanlanganTil = "Русский";
    } else {
      tanlanganTil = "English";
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = MyLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      height: 350.h,
      padding: EdgeInsets.fromLTRB(24.5.w, 30.h, 24.5.w, 31.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 15.h,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                local.switch_language,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: SvgPicture.asset(AppSvgs.cancel,width: 24.w,height: 24.h,),
              ),
            ],
          ),
          SizedBox(height: 5.h),

          _buildLanguageRow(
            flag: AppSvgs.uzb,
            title: "O‘zbekcha",
            localeCode: "uz",
          ),

          _buildLanguageRow(
            flag: AppSvgs.eng,
            title: "English",
            localeCode: "en",
          ),

          _buildLanguageRow(
            flag: AppSvgs.rus,
            title: "Русский",
            localeCode: "ru",
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageRow({
    required String flag,
    required String title,
    required String localeCode,
  }) {
    final ThemeData theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 10.w,
          children: [
            SvgPicture.asset(flag),
            Text(title, style: theme.textTheme.bodyMedium),
          ],
        ),
        Radio<String>(
          value: title,
          groupValue: tanlanganTil,
          onChanged: (value) {
            context.read<LocalizationCubit>().changeLocale(locale: localeCode);
            setState(() => tanlanganTil = value!);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}