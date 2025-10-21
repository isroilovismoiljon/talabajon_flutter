import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/auth_repository.dart';
import 'auth_interceptor.dart';
import 'client.dart';

final dependencies = [
  Provider(create: (context) => FlutterSecureStorage()),
  Provider(create: (context) => AuthInterceptor(secureStorage: context.read())),
  Provider(
    create: (context) => ApiClient(interceptor: context.read(), baseUrl: "http://192.168.11.197:8888/api/v1"),
    // create: (context) => ApiClient(interceptor: context.read(), baseUrl: "http://172.20.10.6:8888/api/v1")
  ),
  Provider(
    create: (context) => AuthRepository(client: context.read(), secureStorage: context.read()),
  ),
];
