part of 'checklist_item_detail_cubit.dart';

abstract class ChecklistItemDetailState extends Equatable {
  const ChecklistItemDetailState();

  @override
  List<Object> get props => [];
}

class ChecklistItemDetailInitial extends ChecklistItemDetailState {}

class CheckListItemDetailLoading extends ChecklistItemDetailState {}

class CheckListItemDetailSuccess extends ChecklistItemDetailState {
  final CheckListItemsModel models;

  const CheckListItemDetailSuccess(this.models);

  @override
  List<Object> get props => [models];
}

class CheckListItemDetailFailed extends ChecklistItemDetailState {
  final String errorMessage;

  const CheckListItemDetailFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
