part of 'delete_checklist_item_cubit.dart';

abstract class DeleteChecklistItemState extends Equatable {
  const DeleteChecklistItemState();

  @override
  List<Object> get props => [];
}

class DeleteChecklistItemInitial extends DeleteChecklistItemState {}

class DeleteCheckListItemLoading extends DeleteChecklistItemState {}

class DeleteCheckListItemSuccess extends DeleteChecklistItemState {
  final String message;

  const DeleteCheckListItemSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class DeleteCheckListItemFailed extends DeleteChecklistItemState {
  final String errorMessage;

  const DeleteCheckListItemFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
