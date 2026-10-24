import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/login_request_entity.dart';
import '../../domain/entities/login_response_entity.dart';
import '../../domain/use_cases/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(LoginInitial());

  Future<void> login(LoginRequestEntity request) async {
    emit(LoginLoading());
    final result = await loginUseCase.invoke(request);
    result.fold(
      (failure) => emit(LoginFailure(failure.failureMessage)),
      (response) => emit(LoginSuccess(response)),
    );
  }
}
