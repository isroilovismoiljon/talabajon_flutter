import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabajon/core/network/client.dart';
import 'package:talabajon/data/repositories/auth_repository.dart';
import 'package:talabajon/features/auth/managers/register/register_event.dart';
import 'package:talabajon/features/auth/managers/register/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{
  final AuthRepository _authRepository;

RegisterBloc({required AuthRepository authRepository})
  : _authRepository = authRepository,
  super(RegisterState.initial());
}