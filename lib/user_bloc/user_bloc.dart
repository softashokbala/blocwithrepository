import 'package:blocwithrepository/repository/user_repository.dart';
import 'package:blocwithrepository/user_bloc/user_event.dart';
import 'package:blocwithrepository/user_bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UserBloc(this.userRepository) : super(UserInitialState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final user = await userRepository.getUsers();
        emit(UserSuccessState(user));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}
