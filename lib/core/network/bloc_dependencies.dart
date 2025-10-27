import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/managers/register/register_bloc.dart';

final blocDependencies = [
  BlocProvider<RegisterBloc>(
    create: (context) => RegisterBloc(authRepository: context.read()),
  ),
  // BlocProvider<LoginBloc>(
  //   create: (context) => LoginBloc(authenticationRepository: context.read()),
  // ),
];
