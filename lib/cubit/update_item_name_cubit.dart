import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_apps/models/action_checklist_model.dart';
import 'package:my_apps/services/checklist_item_service.dart';

part 'update_item_name_state.dart';

class UpdateItemNameCubit extends Cubit<UpdateItemNameState> {
  UpdateItemNameCubit() : super(UpdateItemNameInitial());

  Future<void> updateName(
      {required int id, required int idItem, required String itemName}) async {
    try {
      emit(UpdateItemNameLoading());

      final ActionCheckListsModel model = await ChecklistItemService()
          .updateName(id: id, idItem: idItem, itemName: itemName);

      emit(UpdateItemNameSuccess(model.message ?? ''));
    } catch (e) {
      emit(UpdateItemNameFailed('$e'));
    }
  }
}
