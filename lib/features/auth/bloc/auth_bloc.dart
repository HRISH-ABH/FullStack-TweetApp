import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:tweetapp/app.dart';
import 'package:tweetapp/core/local_db/shared_preferences.dart';
import 'package:tweetapp/features/auth/models/user_model.dart';
import 'package:tweetapp/features/auth/repos/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

enum AuthType { login, register }

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthenticationEvent>(authenticationEvent);
  }

  Future<FutureOr<void>> authenticationEvent(
      AuthenticationEvent event, Emitter<AuthState> emit) async {
    UserCredential? credential;
    switch (event.authType) {
      case AuthType.login:
        try {
          log(event.email);
          log(event.pass);
          credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email,
            password: event.pass,
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            log('No user found for that email');
            emit(
              AuthErrorState(
                error: 'No user found for that email',
              ),
            );
          } else if (e.code == 'wrong-password') {
            log('Wrong password provided for that user');
            emit(
              AuthErrorState(
                error: 'Wrong password provided for that user',
              ),
            );
          }
        }

      case AuthType.register:
        try {
          credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.pass,
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            log('The password provided is too weak.');
            emit(
              AuthErrorState(
                error: 'The password provided is too weak.',
              ),
            );
          } else if (e.code == 'email-already-in-use') {
            log('The account already exists for that email.');
            emit(
              AuthErrorState(
                error: 'The account already exists for that email',
              ),
            );
          }
        } catch (e) {
          log(e.toString());
          emit(
            AuthErrorState(
              error: "Something Wnt Wrong",
            ),
          );
        }

      default:
    }

    if (credential != null) {
      if (event.authType == AuthType.login) {
        UserModel? userModel =
            await AuthRepo.getUserRepo(credential.user?.uid ?? "");
        if (userModel != null) {
          InitialPage.authStream.add(credential.user?.uid ?? "");
          emit(AuthSuccessState());
        }
      } else if (event.authType == AuthType.register) {
        bool success = await AuthRepo.createUserRepo(
          UserModel(
            uid: credential.user?.uid ?? "",
            firstName: "Hrishabh",
            lastName: "Chauhan",
            email: "hrishabhchauhan007@gmail.com",
            createdAt: DateTime.now(),
            tweet: [],
          ),
        );
        if (success) {
          await SharedPreferencesManager.saveUid(credential.user?.uid ?? "");
          InitialPage.authStream.add(credential.user?.uid ?? "");
          emit(AuthSuccessState());
        } else {
          emit(
            AuthErrorState(
              error: "Something Went Wrong",
            ),
          );
        }
      }
    } else {
      log('Credential is null');
      emit(AuthErrorState(error: "Something went Wrong"));
    }
  }
}
