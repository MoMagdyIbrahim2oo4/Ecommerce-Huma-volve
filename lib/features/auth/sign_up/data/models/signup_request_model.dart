import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entities/siginup_request_entity.dart';

class SignupRequestModel extends SiginupRequestEntity {
  SignupRequestModel({
    required super.name,
    required super.email,
    required super.password,
  });
  factory SignupRequestModel.fromEntity(SiginupRequestEntity entity) {
    return SignupRequestModel(
      name: entity.name,
      email: entity.email,
      password: entity.password,
    );
  }
}
