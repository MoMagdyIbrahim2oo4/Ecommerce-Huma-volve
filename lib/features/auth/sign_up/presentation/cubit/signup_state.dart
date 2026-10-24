part of 'signup_cubit.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}
final class SignupLoading extends SignupState {}
final class SignupSuccess extends SignupState {
  final SignupResponseEntity data;
  SignupSuccess(this.data);
}
final class SignupFailure extends SignupState {
  final String errorMessage;
  SignupFailure(this.errorMessage);
}
