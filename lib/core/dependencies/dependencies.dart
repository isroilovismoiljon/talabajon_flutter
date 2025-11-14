import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:talabajon/data/repositories/design_repository.dart';
import 'package:talabajon/data/repositories/payments_repository.dart';
import 'package:talabajon/data/repositories/photo_repository.dart';
import 'package:talabajon/data/repositories/user_repository.dart';

import '../../data/repositories/auth_repository.dart';
import '../network/auth_interceptor.dart';
import '../network/client.dart';

final dependencies = <SingleChildWidget>[
  Provider(create: (context) => FlutterSecureStorage()),
  Provider(create: (context) => AuthInterceptor(secureStorage: context.read())),
  Provider(
    create: (context) => ApiClientStudent(interceptor: context.read(), baseUrl: "http://89.223.126.116/api"),
  ),
  Provider(
    create: (context) => AuthRepository(client: context.read(), secureStorage: context.read()),
  ),
  Provider(
    create: (context) => PhotoRepository(client: context.read()),
  ),
  Provider(
    create: (context) => UserRepository(client: context.read()),
  ),
  Provider(
    create: (context) => DesignRepository(client: context.read()),
  ),
  Provider(
    create: (context) => PaymentsRepository(client: context.read()),
  ),
];
