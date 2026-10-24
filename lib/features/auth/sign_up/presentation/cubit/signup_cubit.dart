import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entities/siginup_request_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entities/signup_response_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/use_cases/signup_use_case.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupUseCase signupUseCase;
  SignupCubit(this.signupUseCase) : super(SignupInitial());
  Future<void> signUp(SiginupRequestEntity signupRequestEntity) async {
    emit(SignupLoading());
    final data = await signupUseCase.invoke(signupRequestEntity);
    data.fold(
      (error) {
        emit(SignupFailure(error.failureMessage));
      },
      (respose) {
        emit(SignupSuccess(respose));
      },
    );
  }
}
