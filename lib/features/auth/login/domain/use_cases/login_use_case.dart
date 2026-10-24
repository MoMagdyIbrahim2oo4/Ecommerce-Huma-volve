import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/utils/failure.dart';

import '../entities/login_request_entity.dart';
import '../entities/login_response_entity.dart';
import '../repos/login_repo.dart';

class LoginUseCase {
  final LoginRepo loginRepo;

  LoginUseCase(this.loginRepo);

  Future<Either<Failure, LoginResponseEntity>> invoke(
    LoginRequestEntity request,
  ) => loginRepo.login(request);
}
