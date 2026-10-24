import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/utils/failure.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entities/siginup_request_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entities/signup_response_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/repos/signup_repo.dart';

class SignupUseCase {
  final SignupRepo signupRepo;
  SignupUseCase(this.signupRepo);
  Future<Either<Failure, SignupResponseEntity>> invoke(
    SiginupRequestEntity siginupRequestEntity,
  ) => signupRepo.signUp(siginupRequestEntity);
}
