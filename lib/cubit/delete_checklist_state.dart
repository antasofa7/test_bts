part of 'delete_checklist_cubit.dart';

abstract class DeleteChecklistState extends Equatable {
  const DeleteChecklistState();

  @override
  List<Object> get props => [];
}

class DeleteChecklistInitial extends DeleteChecklistState {}

class DeleteCheckListLoading extends DeleteChecklistState {}

class DeleteCheckListSuccess extends DeleteChecklistState {
  final String message;

  const DeleteCheckListSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class DeleteCheckListFailed extends DeleteChecklistState {
  final String errorMessage;

  const DeleteCheckListFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
