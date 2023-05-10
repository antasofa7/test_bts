import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_apps/models/checklist_model.dart';
import 'package:my_apps/services/checklist_service.dart';

part 'checklists_state.dart';

class ChecklistsCubit extends Cubit<ChecklistsState> {
  ChecklistsCubit() : super(ChecklistsInitial());

  Future<void> get() async {
    try {
      emit(CheckListLoading());
      final models = await ChecklistService().get();

      emit(CheckListSuccess(models));
    } catch (e) {
      emit(CheckListFailed('$e'));
    }
  }
}
