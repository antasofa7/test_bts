import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_apps/models/action_checklist_model.dart';
import 'package:my_apps/services/checklist_item_service.dart';

part 'save_checklist_item_state.dart';

class SaveChecklistItemCubit extends Cubit<SaveChecklistItemState> {
  SaveChecklistItemCubit() : super(SaveChecklistItemInitial());

  Future<void> save({required int id, required String itemName}) async {
    try {
      emit(SaveCheckListItemLoading());

      final ActionCheckListsModel model =
          await ChecklistItemService().save(id: id, itemName: itemName);

      emit(SaveCheckListItemSuccess(model.message ?? ''));
    } catch (e) {
      emit(SaveCheckListItemFailed('$e'));
    }
  }
}
