import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_apps/services/checklist_item_service.dart';

import '../models/checklist_item_model.dart';

part 'checklist_item_detail_state.dart';

class ChecklistItemDetailCubit extends Cubit<ChecklistItemDetailState> {
  ChecklistItemDetailCubit() : super(ChecklistItemDetailInitial());

  Future<void> get({required int id, required int idItem}) async {
    try {
      emit(CheckListItemDetailLoading());
      final models =
          await ChecklistItemService().getDetail(id: id, idItem: idItem);

      emit(CheckListItemDetailSuccess(models));
    } catch (e) {
      emit(CheckListItemDetailFailed('$e'));
    }
  }
}
