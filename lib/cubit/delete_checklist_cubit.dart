import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_apps/models/action_checklist_model.dart';
import 'package:my_apps/services/checklist_service.dart';

part 'delete_checklist_state.dart';

class DeleteChecklistCubit extends Cubit<DeleteChecklistState> {
  DeleteChecklistCubit() : super(DeleteChecklistInitial());

  Future<void> delete({required int id}) async {
    try {
      emit(DeleteCheckListLoading());
      final ActionCheckListsModel model =
          await ChecklistService().delete(id: id);
      emit(DeleteCheckListSuccess(model.message ?? ''));
    } catch (e) {
      emit(DeleteCheckListFailed('$e'));
    }
  }
}
