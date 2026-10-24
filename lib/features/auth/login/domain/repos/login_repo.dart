import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/utils/failure.dart';

import '../entities/login_request_entity.dart';
import '../entities/login_response_entity.dart';

abstract class LoginRepo {
  Future<Either<Failure, LoginResponseEntity>> login(
    LoginRequestEntity request,
  );
}
