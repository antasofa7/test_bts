import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_apps/models/auth_model.dart';
import 'package:my_apps/services/auth_service.dart';
import 'package:my_apps/services/user_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void login({required String username, required String password}) async {
    try {
      emit(AuthLoading());
      final res =
          await AuthService().login(username: username, password: password);
      if (res.errorMessage == '') {
        emit(AuthSuccess(res));
      } else {
        emit(AuthErrors(res));
      }
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void logout() async {
    try {
      emit(AuthLoading());
      await AuthService().logout();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void isLoggedIn() async {
    try {
      String token = await UserService().getToken();
      // var user = SuccessAuthModel.fromJson(jsonDecode(token));
      emit(IsAuthenticated(token));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
