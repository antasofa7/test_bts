part of 'update_item_status_cubit.dart';

abstract class UpdateItemStatusState extends Equatable {
  const UpdateItemStatusState();

  @override
  List<Object> get props => [];
}

class UpdateItemStatusInitial extends UpdateItemStatusState {}

class UpdateItemStatusLoading extends UpdateItemStatusState {}

class UpdateItemStatusSuccess extends UpdateItemStatusState {
  final String message;

  const UpdateItemStatusSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateItemStatusFailed extends UpdateItemStatusState {
  final String errorMessage;

  const UpdateItemStatusFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
