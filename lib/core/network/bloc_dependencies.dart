import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

import '../../features/auth/managers/register/register_bloc.dart';

final blocDependencies = <SingleChildWidget> [
  BlocProvider<RegisterBloc>(
    create: (context) => RegisterBloc(authRepo: context.read()),
  ),
  // BlocProvider<LoginBloc>(
  //   create: (context) => LoginBloc(authenticationRepository: context.read()),
  // ),
];
