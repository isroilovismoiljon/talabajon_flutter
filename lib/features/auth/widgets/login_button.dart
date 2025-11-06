import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabajon/core/constants/status.dart';
import 'package:talabajon/core/utils/svgs.dart';
import 'package:talabajon/data/models/auth/login_request_model.dart';
import 'package:talabajon/features/auth/managers/login/login_bloc.dart';
import 'package:talabajon/features/auth/managers/login/login_event.dart';
import 'package:talabajon/features/auth/managers/login/login_state.dart';
import 'package:talabajon/features/common/widgets/custom_svg_button.dart';
import '../../../core/l10n/app_localizations.dart';

class LoginButton extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const LoginButton({
    super.key,
    required this.usernameController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    final local = MyLocalizations.of(context)!;

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        final isLoading = state.loginStatus == Status.loading;
        return ValueListenableBuilder<TextEditingValue>(
          valueListenable: usernameController,
          builder: (context, usernameValue, _) {
            return ValueListenableBuilder<TextEditingValue>(
              valueListenable: passwordController,
              builder: (context, passwordValue, _) {
                final isDisabled = isLoading ||
                    usernameValue.text.trim().isEmpty ||
                    passwordValue.text.trim().isEmpty;
                return CustomSvgButton(
                  title: isLoading ? 'Loading...' : local.login,
                  svg: AppSvgs.login,
                  width: 390,
                  height: 60,
                  onPressed: isDisabled
                      ? null
                      : () {
                    context.read<LoginBloc>().add(
                      LoginPostEvent(
                        LoginRequestModel(
                          username: usernameValue.text.trim(),
                          password: passwordValue.text.trim(),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
