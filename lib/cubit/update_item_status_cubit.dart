import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_apps/models/action_checklist_model.dart';

import '../services/checklist_item_service.dart';

part 'update_item_status_state.dart';

class UpdateItemStatusCubit extends Cubit<UpdateItemStatusState> {
  UpdateItemStatusCubit() : super(UpdateItemStatusInitial());

  Future<void> updateStatus({required int id, required int idItem}) async {
    try {
      emit(UpdateItemStatusLoading());

      final ActionCheckListsModel model =
          await ChecklistItemService().updateStatus(id: id, idItem: idItem);

      emit(UpdateItemStatusSuccess(model.message ?? ''));
    } catch (e) {
      emit(UpdateItemStatusFailed('$e'));
    }
  }
}
