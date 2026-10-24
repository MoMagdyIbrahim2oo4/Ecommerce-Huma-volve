import '../../domain/entities/login_request_entity.dart';

class LoginRequestModel extends LoginRequestEntity {
  const LoginRequestModel({required super.email, required super.password});

  factory LoginRequestModel.fromEntity(LoginRequestEntity entity) =>
      LoginRequestModel(email: entity.email, password: entity.password);
}
