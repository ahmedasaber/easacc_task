import 'package:dartz/dartz.dart';
import 'package:easacc_task/features/auth/domain/repo/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../../core/services/firebase_auth_service.dart';
import '../../domain/entities/user_entity.dart';
import '../models/user_model.dart';

class AuthRepoImpl extends AuthRepo{
  final FirebaseAuthService firebaseAuthService;

  AuthRepoImpl({required this.firebaseAuthService});

  var logger = Logger();

  @override
  Future<Either<Exception, UserEntity>> singInWithGoogle({required BuildContext context,}) async{
    User? user;
    try {
      user = await firebaseAuthService.signInWithGoogle(context: context,);
      var userEntity = UserModel.fromFirebaseUser(user);
      return right(userEntity);
    } on Exception catch (e) {
      return left(e);
    }catch (e){
      logger.w('Exception in AuthRepoImpl.singInWithGoogle: ${e.toString()}');
      return left(Exception('Something error please try again'));
    }
  }

  @override
  Future<Either<Exception, UserEntity>> singInWithFacebook({required BuildContext context,}) async{
    User? user;
    try {
      user = await firebaseAuthService.signInWithFacebook(context: context,);
      var userEntity = UserModel.fromFirebaseUser(user);
      return right(userEntity);
    } on Exception catch (e) {
      return left(e);
    }catch (e){
      logger.w('Exception in AuthRepoImpl.singInWithFacebook: ${e.toString()} code: ${e.runtimeType}');
      return left(Exception('Something error please try again'));
    }
  }
  @override
  Future<void> logOut() async {
    firebaseAuthService.logOut();
  }
}