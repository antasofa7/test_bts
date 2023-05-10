part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final AuthModel users;

  const AuthSuccess(this.users);

  @override
  List<Object> get props => [users];
}

class IsAuthenticated extends AuthState {
  final String token;

  const IsAuthenticated(this.token);

  @override
  List<Object> get props => [token];
}

class AuthErrors extends AuthState {
  final AuthModel errors;

  const AuthErrors(this.errors);

  @override
  List<Object> get props => [errors];
}

class AuthFailed extends AuthState {
  final String errorMessage;

  const AuthFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
