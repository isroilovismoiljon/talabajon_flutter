import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:talabajon/core/constants/status.dart';
import 'package:talabajon/core/utils/styles.dart';
import 'package:talabajon/features/service/managers/design/design_bloc.dart';
import 'package:talabajon/features/service/managers/design/design_event.dart';
import 'package:talabajon/features/service/managers/design/design_state.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/svgs.dart';

class PresentationTemplateBottomSheet extends StatefulWidget {
  const PresentationTemplateBottomSheet({super.key});

  @override
  State<PresentationTemplateBottomSheet> createState() => _PresentationTemplateBottomSheetState();
}

class _PresentationTemplateBottomSheetState extends State<PresentationTemplateBottomSheet> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DesignBloc, DesignState>(
      builder: (context, state) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.8,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 146.w,
                    height: 5.h,
                    decoration: BoxDecoration(
                      color: AppColors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 9.h),
                    prefixIcon: SizedBox(
                      width: 24.w,
                      height: 24.h,
                      child: Center(
                        child: SvgPicture.asset(
                          AppSvgs.search,
                          colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                        ),
                      ),
                    ),
                    hintText: "Search Images",
                    hintStyle: TextStyle(color: AppColors.hintText),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7.r),
                      borderSide: BorderSide(color: AppColors.border),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Expanded(
                  child: state.designStatus == Status.loading
                      ? const Center(child: CircularProgressIndicator())
                      : GridView.builder(
                          controller: scrollController,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.w,
                            mainAxisSpacing: 10.h,
                            mainAxisExtent: 115.h,
                            childAspectRatio: 1.2,
                          ),
                          itemCount: state.design?.data.designs.length ?? 0,
                          itemBuilder: (context, index) {
                            final designItem = state.design!.data.designs[index];
                            final isSelected = state.selectedPhotos == designItem;

                            return GestureDetector(
                              onTap: () {
                                context.read<DesignBloc>().add(SelectDesignPhotoEvent(designItem));
                                context.pop();
                              },
                              onLongPress: () {
                                context.read<DesignBloc>().add(
                                  DesignDetailEvent(
                                    id: state.design!.data.designs[index].id,
                                  ),
                                );
                                showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (_) => BlocBuilder<DesignBloc, DesignState>(
                                    builder: (context, state) {
                                      if (state.detailStatus == Status.loading) {
                                        return const Center(
                                          child: CircularProgressIndicator(color: Colors.white),
                                        );
                                      }
                                      return GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Dialog(
                                          backgroundColor: Colors.transparent,
                                          insetPadding: EdgeInsets.all(20.w),
                                          child: (state.detail == null || state.detail!.data!.photos.isEmpty)
                                              ? const Center(
                                                  child: Text(
                                                    "Rasmlar topilmadi",
                                                    style: TextStyle(color: Colors.white70),
                                                  ),
                                                )
                                              : GridView.builder(
                                                  shrinkWrap: true,
                                                  physics: const BouncingScrollPhysics(),
                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 10.w,
                                                    mainAxisSpacing: 10.h,
                                                    mainAxisExtent: 115.h,
                                                    childAspectRatio: 1.2,
                                                  ),
                                                  itemCount: state.detail!.data!.photos.length,
                                                  itemBuilder: (context, indexDetail) {
                                                    final photo = state.detail!.data!.photos[indexDetail];
                                                    return Stack(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(color: Colors.grey[300]!),
                                                            borderRadius: BorderRadius.circular(10.r),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors.grey.withAlpha(10),
                                                                blurRadius: 4,
                                                                offset: const Offset(0, 2),
                                                              ),
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(10.r),
                                                            child: Image.network(
                                                              photo.photoUrl,
                                                              fit: BoxFit.cover,
                                                              width: double.infinity,
                                                              height: double.infinity,
                                                              errorBuilder: (context, error, stackTrace) => const Center(
                                                                child: Icon(Icons.broken_image, color: Colors.red),
                                                              ),
                                                              loadingBuilder: (context, child, progress) {
                                                                if (progress == null) return child;
                                                                return const Center(
                                                                  child: CircularProgressIndicator(),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 10.w,
                                                          bottom: 9.h,
                                                          child: Container(
                                                            width: 47.w,
                                                            height: 20.h,
                                                            decoration: BoxDecoration(
                                                              color: Colors.grey.withAlpha(200),
                                                              borderRadius: BorderRadius.circular(7.r),
                                                            ),
                                                            padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 1.h),
                                                            child: Center(
                                                              child: Text(
                                                                "${indexDetail + 1}",
                                                                style: AppStyles.w400s14w,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey[300]!),
                                      borderRadius: BorderRadius.circular(10.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withValues(alpha: 0.1),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: Image.network(
                                        designItem.firstPhotoUrl,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                    ),
                                  ),
                                  if (isSelected)
                                    Positioned(
                                      top: 6,
                                      right: 6,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.circle,
                                        ),
                                        padding: const EdgeInsets.all(4),
                                        child: const Icon(Icons.check, size: 14, color: Colors.white),
                                      ),
                                    ),
                                  Positioned(
                                    left: 10.w,
                                    bottom: 9.h,
                                    child: Container(
                                      width: 47.w,
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withValues(alpha: 0.8),
                                        borderRadius: BorderRadius.circular(7.r),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 1.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SvgPicture.asset(
                                            AppSvgs.copy,
                                            width: 18.w,
                                            height: 18.h,
                                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                          ),
                                          Text(
                                            "${designItem.photoCount}",
                                            style: AppStyles.w400s14w,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
