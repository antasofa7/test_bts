import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_apps/models/action_checklist_model.dart';
import 'package:my_apps/services/checklist_service.dart';

part 'save_checklist_state.dart';

class SaveChecklistCubit extends Cubit<SaveChecklistState> {
  SaveChecklistCubit() : super(SaveChecklistInitial());

  Future<void> save({required String name}) async {
    try {
      emit(SaveCheckListLoading());

      final ActionCheckListsModel model =
          await ChecklistService().save(name: name);

      emit(SaveCheckListSuccess(model.message ?? ''));
    } catch (e) {
      emit(SaveCheckListFailed('$e'));
    }
  }
}
