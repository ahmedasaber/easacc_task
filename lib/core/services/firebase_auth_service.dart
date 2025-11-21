import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class FirebaseAuthService{
  var logger = Logger();

  Future<User> signInWithGoogle({required BuildContext context}) async {
    final genericErrorMsg = 'Something error please try again';
    try{
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return (await FirebaseAuth.instance.signInWithCredential(credential)).user!;
    }catch (e){
      logger.w('Google Sign-In error: ${e.toString()}');
      throw Exception(genericErrorMsg);
    }
  }

  Future<User> signInWithFacebook({required BuildContext context}) async {
    final facebookAccountExistsDifferentCredentialMsg = 'this Account is already Exists';
    final facebookLoginErrorMsg = 'Login error';

   try{
     // Trigger the sign-in flow
     final LoginResult loginResult = await FacebookAuth.instance.login();

     // Create a credential from the access token
     final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

     // Once signed in, return the UserCredential
     return (await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential)).user!;
   } on FirebaseAuthException catch(e){
       logger.w('$Exception in FirebaseAuthService.createAccountWithEmail: ${e.toString()} - code: ${e.code}');
       if(e.code == 'account-exists-with-different-credential'){
         throw Exception( facebookAccountExistsDifferentCredentialMsg);
       }
       throw Exception(facebookLoginErrorMsg);
   }catch (e){
       logger.w('mException in FirebaseAuthService.createAccountWithEmail: ${e.toString()}');
       throw Exception(facebookLoginErrorMsg);
   }
  }

  bool isLoggIn(){
    return FirebaseAuth.instance.currentUser != null;
  }

  void logOut(){
    FirebaseAuth.instance.signOut();
  }
}