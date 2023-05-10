import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_apps/models/action_checklist_model.dart';

import '../services/checklist_item_service.dart';

part 'delete_checklist_item_state.dart';

class DeleteChecklistItemCubit extends Cubit<DeleteChecklistItemState> {
  DeleteChecklistItemCubit() : super(DeleteChecklistItemInitial());

  Future<void> delete({required int id, required int idItem}) async {
    try {
      emit(DeleteCheckListItemLoading());
      final ActionCheckListsModel model =
          await ChecklistItemService().delete(id: id, idItem: idItem);
      emit(DeleteCheckListItemSuccess(model.message ?? ''));
    } catch (e) {
      emit(DeleteCheckListItemFailed('$e'));
    }
  }
}
