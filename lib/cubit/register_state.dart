part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final RegisterModel register;

  const RegisterSuccess(this.register);

  @override
  List<Object> get props => [register];
}

class RegisterFailed extends RegisterState {
  final String errorMessage;

  const RegisterFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
