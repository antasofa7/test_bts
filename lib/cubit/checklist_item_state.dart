part of 'checklist_item_cubit.dart';

abstract class ChecklistItemState extends Equatable {
  const ChecklistItemState();

  @override
  List<Object> get props => [];
}

class ChecklistItemInitial extends ChecklistItemState {}

class CheckListItemLoading extends ChecklistItemState {}

class CheckListItemSuccess extends ChecklistItemState {
  final CheckListItemsModel models;

  const CheckListItemSuccess(this.models);

  @override
  List<Object> get props => [models];
}

class CheckListItemFailed extends ChecklistItemState {
  final String errorMessage;

  const CheckListItemFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
