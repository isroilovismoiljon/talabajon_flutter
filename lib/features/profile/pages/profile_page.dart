import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/svgs.dart';
import 'package:talabajon/data/models/user/update_profile_model.dart';
import 'package:talabajon/features/auth/widgets/custom_text_field.dart';
import 'package:talabajon/features/common/widgets/custom_button.dart';
import 'package:talabajon/features/home/managers/me_bloc.dart';
import 'package:talabajon/features/home/managers/me_state.dart';
import 'package:talabajon/features/profile/managers/profile_bloc.dart';
import 'package:talabajon/features/profile/managers/profile_event.dart';
import 'package:talabajon/features/profile/managers/profile_state.dart';

import '../../../core/constants/status.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../data/models/user/me_model.dart';
import '../../common/widgets/app_bar_common.dart';
import '../../common/widgets/custom_bottom_navigation_bar.dart';
import '../../home/managers/me_event.dart';
import '../widgets/profile_avatar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  File? userImage;

  @override
  void initState() {
    super.initState();
    final meState = context.read<MeBloc>().state;
    if (meState.userMe != null) {
      _setUserData(meState.userMe!.data);
    }
  }

  void _setUserData(UserData user) {
    firstnameController.text = user.firstName;
    lastnameController.text = user.lastName;
    usernameController.text = user.username;
    phoneNumberController.text = user.phoneNumber ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final local = MyLocalizations.of(context)!;

    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.profileStatus == Status.success) {
          if (state.profile?.success == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("✅ ${state.profile?.message ?? "Profile updated successfully"}"),
              ),
            );
            context.read<MeBloc>().add(MeEvent());
            context.pop();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("❎ ${state.profile?.message ?? "Profile updated failed"}"),
              ),
            );
          }
        }
      },
      child: BlocBuilder<MeBloc, MeState>(
        builder: (context, state) {
          if (state.userMe != null) {
            _setUserData(state.userMe!.data);
          }

          return Scaffold(
            appBar: AppBarCommon(title: local.edit_profile),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 69.h, 20.w, 0),
                child: state.meStatus == Status.loading
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ProfileAvatar(
                            initialPhoto: state.userMe?.data.photo,
                            onPhotoChanged: (file) {
                              userImage = file;
                            },
                          ),

                          SizedBox(height: 21.h),
                          Column(
                            children: [
                              CustomTextField(
                                controller: firstnameController,
                                icon: AppSvgs.account,
                                hintText: local.first_name,
                                svgColor: AppColors.hintText,
                              ),
                              SizedBox(height: 10.h),
                              CustomTextField(
                                controller: lastnameController,
                                icon: AppSvgs.account,
                                hintText: local.last_name,
                                svgColor: AppColors.hintText,
                              ),
                              SizedBox(height: 10.h),
                              CustomTextField(
                                controller: usernameController,
                                icon: AppSvgs.userName,
                                hintText: local.username,
                                svgColor: AppColors.hintText,
                              ),
                              SizedBox(height: 10.h),
                              CustomTextField(
                                controller: phoneNumberController,
                                icon: AppSvgs.phone,
                                hintText: local.phone_number,
                                svgColor: AppColors.hintText,
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          CustomButton(
                            title: local.update_profile,
                            onPressed: () {
                              context.read<ProfileBloc>().add(
                                UpdateProfileEvent(
                                  profile: UpdateProfileModel(
                                    firstName: firstnameController.text,
                                    lastName: lastnameController.text,
                                    userName: usernameController.text,
                                    phoneNumber: phoneNumberController.text,
                                    photo: userImage,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
              ),
            ),
            bottomNavigationBar: CustomBottomNavigationBar(activeIndex: 3),
          );
        },
      ),
    );
  }
}
