import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repo/auth_repo.dart';

part 'signin_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this.authRepo) : super(SignInInitial());

  final AuthRepo authRepo;

  Future<void> signInWithGoogle(BuildContext context,) async {
    emit(SignInLoading());
    var result = await authRepo.singInWithGoogle(context: context,);
    result.fold(
      (failure) => emit(SignInFailure(message: failure.toString())),
      (userEntity) => emit(SignInSuccess(userEntity: userEntity)),
    );
  }

  Future<void> signInWithFacebook(BuildContext context,) async {
    emit(SignInLoading());
    var result = await authRepo.singInWithFacebook(context: context,);
    result.fold(
      (failure) => emit(SignInFailure(message: failure.toString())),
      (userEntity) => emit(SignInSuccess(userEntity: userEntity)),
    );
  }

}
