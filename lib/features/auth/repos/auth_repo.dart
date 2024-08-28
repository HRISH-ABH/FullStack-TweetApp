import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tweetapp/core/api_services/config.dart';
import 'package:tweetapp/features/auth/models/user_model.dart';

class AuthRepo {
  static Future<UserModel?> getUserRepo(String uid) async {
    try {
      Dio dio = Dio();

      final response = await dio.get(Config.serverURL + "user/{$uid}");

      if (response.statusCode == 200) {
        UserModel userModel = UserModel.fromMap(response.data);
        return userModel;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<bool> createUserRepo(UserModel userModel) async {
    Dio dio = Dio();

    final response = await dio.post(Config.serverURL + "user",data: userModel.toMap());

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
