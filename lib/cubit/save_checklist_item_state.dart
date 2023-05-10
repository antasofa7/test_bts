part of 'save_checklist_item_cubit.dart';

abstract class SaveChecklistItemState extends Equatable {
  const SaveChecklistItemState();

  @override
  List<Object> get props => [];
}

class SaveChecklistItemInitial extends SaveChecklistItemState {}

class SaveCheckListItemLoading extends SaveChecklistItemState {}

class SaveCheckListItemSuccess extends SaveChecklistItemState {
  final String message;

  const SaveCheckListItemSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class SaveCheckListItemFailed extends SaveChecklistItemState {
  final String errorMessage;

  const SaveCheckListItemFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
