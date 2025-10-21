import 'package:flutter_bloc/flutter_bloc.dart';

final blocDependencies = [
  BlocProvider<RegisterBloc>(
    create: (context) => RegisterBloc(authenticationRepository: context.read()),
  ),
  BlocProvider<LoginBloc>(
    create: (context) => LoginBloc(authenticationRepository: context.read()),
  ),
];
