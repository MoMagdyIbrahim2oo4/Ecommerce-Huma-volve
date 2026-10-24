import '../../domain/entities/login_response_entity.dart';

class LoginResponseModel extends LoginResponseEntity {
  const LoginResponseModel({super.accessToken, super.refreshToken});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        accessToken: json['access_token'] as String?,
        refreshToken: json['refresh_token'] as String?,
      );
}
