part of 'update_item_name_cubit.dart';

abstract class UpdateItemNameState extends Equatable {
  const UpdateItemNameState();

  @override
  List<Object> get props => [];
}

class UpdateItemNameInitial extends UpdateItemNameState {}

class UpdateItemNameLoading extends UpdateItemNameState {}

class UpdateItemNameSuccess extends UpdateItemNameState {
  final String message;

  const UpdateItemNameSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateItemNameFailed extends UpdateItemNameState {
  final String errorMessage;

  const UpdateItemNameFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
