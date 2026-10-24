import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/models/signup_request_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/models/signup_response_model.dart';

abstract class SignupRemoteDataSource {
  Future<SignupResponseModel> signUp(SignupRequestModel signupRequest);
}