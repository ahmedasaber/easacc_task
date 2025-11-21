import 'package:easacc_task/features/auth/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo{
  Future<Either<Exception, UserEntity>> singInWithGoogle({required BuildContext context,});
  Future<Either<Exception, UserEntity>> singInWithFacebook({required BuildContext context,});
  Future<void> logOut();
}