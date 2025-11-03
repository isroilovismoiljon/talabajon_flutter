import 'package:flutter/material.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/styles.dart';
import 'package:talabajon/core/utils/svgs.dart';
import 'package:talabajon/features/home/widgets/small_svg_button.dart';
import 'package:talabajon/features/service/widgets/custom_empty_field.dart';

class PageCountRow extends StatefulWidget {
  final TextEditingController controller;

  const PageCountRow({
    super.key,
    required this.controller,
  });

  @override
  State<PageCountRow> createState() => _PageCountRowState();
}

class _PageCountRowState extends State<PageCountRow> {
  int get pageCount {
    final text = widget.controller.text.trim();
    if (text.isEmpty) return 0;
    return int.tryParse(text) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final count = pageCount;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SmallSvgButton(
          svg: AppSvgs.minus,
          width: 126,
          height: 50,
          borderRadius: 82,
          color: AppColors.indigoBlue,
          onPressed: count > 0
              ? () {
                  widget.controller.text = (count - 1).toString();
                  setState(() {});
                }
              : null,
        ),
        CustomEmptyField(
          controller: widget.controller,
          titleHint: "0",
          width: 126,
          border: 82,
          align: TextAlign.center,
          style: AppStyles.w400s20,
        ),

        SmallSvgButton(
          svg: AppSvgs.plus,
          width: 126,
          height: 50,
          borderRadius: 82,
          color: AppColors.indigoBlue,
          onPressed: () {
            widget.controller.text = (count + 1).toString();
            setState(() {});
          },
        ),
      ],
    );
  }
}
