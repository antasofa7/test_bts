import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_apps/services/checklist_item_service.dart';

import '../models/checklist_item_model.dart';

part 'checklist_item_state.dart';

class ChecklistItemCubit extends Cubit<ChecklistItemState> {
  ChecklistItemCubit() : super(ChecklistItemInitial());

  Future<void> get({required int id}) async {
    try {
      emit(CheckListItemLoading());
      final models = await ChecklistItemService().get(id: id);

      emit(CheckListItemSuccess(models));
    } catch (e) {
      emit(CheckListItemFailed('$e'));
    }
  }
}
