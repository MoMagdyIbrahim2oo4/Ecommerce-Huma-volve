import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/data_source/signup_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/models/signup_request_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/models/signup_response_model.dart';

class SignupRemoteDataSourceImp implements SignupRemoteDataSource{
  final ApiClient apiClient;
  SignupRemoteDataSourceImp(this.apiClient);
  @override
  Future<SignupResponseModel> signUp(SignupRequestModel signupRequest) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.signupEndpoint,
      data: {
        "email": signupRequest.email,
        "name": signupRequest.name,
        "password": signupRequest.password,
        "avatar": "https://api.lorem.space/image/face?w=640&h=480",
      },
    );
    return SignupResponseModel.fromJson(response.data);
  }
}
