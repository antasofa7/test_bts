import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_apps/models/register_model.dart';
import 'package:my_apps/services/auth_service.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  void register(
      {required String email,
      required String password,
      required String username}) async {
    try {
      emit(RegisterLoading());
      final RegisterModel res = await AuthService()
          .register(email: email, password: password, username: username);

      if (res.statusCode == 2000) {
        emit(RegisterSuccess(res));
      } else {
        emit(RegisterFailed(res.errorMessage!));
      }
    } catch (e) {
      emit(RegisterFailed(e.toString()));
    }
  }
}
