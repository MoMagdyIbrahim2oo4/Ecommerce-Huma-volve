import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/storage/secure_storage.dart';
import 'package:ecommerce_app_huma_volve/core/utils/error_handler.dart';
import 'package:ecommerce_app_huma_volve/core/utils/failure.dart';

import '../../domain/entities/login_request_entity.dart';
import '../../domain/entities/login_response_entity.dart';
import '../../domain/repos/login_repo.dart';
import '../data_source/login_remote_data_source.dart';
import '../models/login_request_model.dart';

class LoginRepoImp implements LoginRepo {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepoImp(this.remoteDataSource);

  @override
  Future<Either<Failure, LoginResponseEntity>> login(
    LoginRequestEntity request,
  ) async {
    try {
      final response = await remoteDataSource.login(
        LoginRequestModel.fromEntity(request),
      );
      SecureStorage.writeKeys(
        accessToken: response.accessToken ?? '',
        refreshToken: response.refreshToken ?? '',
      );
      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }
}
