part of 'save_checklist_cubit.dart';

abstract class SaveChecklistState extends Equatable {
  const SaveChecklistState();

  @override
  List<Object> get props => [];
}

class SaveChecklistInitial extends SaveChecklistState {}

class SaveCheckListLoading extends SaveChecklistState {}

class SaveCheckListSuccess extends SaveChecklistState {
  final String message;

  const SaveCheckListSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class SaveCheckListFailed extends SaveChecklistState {
  final String errorMessage;

  const SaveCheckListFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
