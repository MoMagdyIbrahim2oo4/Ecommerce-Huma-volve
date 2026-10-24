import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/utils/error_handler.dart';
import 'package:ecommerce_app_huma_volve/core/utils/failure.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/data_source/signup_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/models/signup_request_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entities/siginup_request_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entities/signup_response_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/repos/signup_repo.dart';

class SignupRepoImp implements SignupRepo{
  final SignupRemoteDataSource signupRemoteDataSource;
  SignupRepoImp(this.signupRemoteDataSource);
  @override
  Future<Either<Failure, SignupResponseEntity>> signUp(SiginupRequestEntity siginupRequestEntity) async {
    try{
      final requestModel=SignupRequestModel.fromEntity(siginupRequestEntity);
      final signupRespose= await signupRemoteDataSource.signUp(requestModel);
      return Right(signupRespose);
    }
    catch(error){
      return Left(ErrorHandler.handle(error));
    }
  }
}