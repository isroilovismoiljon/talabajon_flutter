import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:talabajon/core/constants/status.dart';
import 'package:talabajon/core/routing/routes.dart';
import 'package:talabajon/core/utils/colors.dart';
import 'package:talabajon/core/utils/styles.dart';
import 'package:talabajon/features/auth/managers/register/register_state.dart';
import 'package:talabajon/features/auth/widgets/custom_text_field.dart';
import 'package:talabajon/features/auth/widgets/custom_text_field_password.dart';
import 'package:talabajon/features/common/widgets/custom_button.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/utils/icons.dart';
import '../../../data/models/auth/register_request_model.dart';
import '../managers/register/register_bloc.dart';
import '../managers/register/register_event.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final referralController = TextEditingController();
  bool isFormValid = false;
  @override
  void initState() {
    super.initState();
    nameController.addListener(validateForm);
    lastNameController.addListener(validateForm);
    usernameController.addListener(validateForm);
    passwordController.addListener(validateForm);
  }

  void validateForm() {
    final valid =
        nameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;

    if (valid != isFormValid) {
      setState(() {
        isFormValid = valid;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    referralController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = MyLocalizations.of(context)!;

    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.registerStatus == Status.success) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text("code: ${state.register?.data?.telegramDeepLink} ${state.register!.data!.user!.id}"),
          //   ),
          // );
          context.go(Routes.verify, extra: {"registerInfo": state.register});
        }else if (state.registerStatus == Status.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("error: ${state.errorMessage}"),
            ),
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 118.h, 20.w, 110.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(local.create_account, style: AppStyles.w700s24),
              Text(local.create_account_to_use_app),
              SizedBox(height: 114.h),
              Column(
                spacing: 10.h,
                children: [
                  CustomTextField(
                    controller: nameController,
                    icon: AppSvgs.account,
                    hintText: local.first_name,
                  ),
                  CustomTextField(
                    controller: lastNameController,
                    icon: AppSvgs.account,
                    hintText: local.last_name,
                  ),
                  CustomTextField(
                    controller: usernameController,
                    icon: AppSvgs.userName,
                    hintText: local.username,
                  ),
                  CustomTextFieldPassword(
                    controller: passwordController,
                    icon: AppSvgs.password,
                    hint: local.password,
                  ),
                  CustomTextField(
                    controller: referralController,
                    icon: AppSvgs.referal,
                    hintText: local.referral_id,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) => CustomButton(
                  title: state.registerStatus == Status.loading ? "Loading..." : local.create_account,
                  color: AppColors.indigoBlue,
                  onPressed: isFormValid
                      ? () {
                          context.read<RegisterBloc>().add(
                            RegisterPostEvent(
                              RegisterRequestModel(
                                username: usernameController.text.trim(),
                                firstName: nameController.text.trim(),
                                lastName: lastNameController.text.trim(),
                                password: passwordController.text.trim(),
                                referralId: referralController.text.trim().isEmpty ? null : int.tryParse(referralController.text.trim()),
                              ),
                            ),
                          );
                        }
                      : null,
                ),
              ),
              SizedBox(height: 30.h),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: AppStyles.w400s12,
                    children: [
                      TextSpan(
                        text: "Already have an account? ",
                      ),
                      TextSpan(
                        text: "Login",
                        style: AppStyles.w500s12.copyWith(color: AppColors.indigoBlue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.go(Routes.login);
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
