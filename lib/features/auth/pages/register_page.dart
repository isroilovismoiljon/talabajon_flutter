import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talabajon/features/auth/pages/custom_text_field.dart';

import '../../../core/utils/icons.dart';

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
  final referIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 118.h,
          ),
          Text('Hisob yarating'),
          Text('Ilovadan foydalanish uchun hisob yarating'),
          SizedBox(
            height: 114.h,
          ),
          Column(
            spacing: 10.h,
            children: [
              CustomTextField(
                nameController: nameController,
                icon: AppIcons.account,
                hintText: 'Ism',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
