part of 'login_bloc_bloc.dart';

@immutable
sealed class LoginBlocState {}

final class LoginInitialState extends LoginBlocState {}

final class LoginSuccessState extends LoginBlocState {}

final class LoginLoadingState extends LoginBlocState {}

final class LoginFailureState extends LoginBlocState {
  final String message;

  LoginFailureState({this.message = apiErrorMessage});
}
