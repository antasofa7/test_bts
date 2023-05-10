part of 'checklists_cubit.dart';

abstract class ChecklistsState extends Equatable {
  const ChecklistsState();

  @override
  List<Object> get props => [];
}

class ChecklistsInitial extends ChecklistsState {}

class CheckListLoading extends ChecklistsState {}

class CheckListSuccess extends ChecklistsState {
  final CheckListsModel models;

  const CheckListSuccess(this.models);

  @override
  List<Object> get props => [models];
}

class CheckListFailed extends ChecklistsState {
  final String errorMessage;

  const CheckListFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
