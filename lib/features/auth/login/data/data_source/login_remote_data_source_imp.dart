import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';

import '../models/login_request_model.dart';
import '../models/login_response_model.dart';
import 'login_remote_data_source.dart';

class LoginRemoteDataSourceImp implements LoginRemoteDataSource {
  final ApiClient apiClient;

  LoginRemoteDataSourceImp(this.apiClient);

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.loginEndpoint,
      data: {'email': request.email, 'password': request.password},
    );
    return LoginResponseModel.fromJson(response.data);
  }
}
