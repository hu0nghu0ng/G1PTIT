import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioProvider {
  // register new user
  Future<dynamic> registerUser(String username, String email, String pasword) async {

    try {
      var user = await Dio().post(
        'http://localhost:6699/huong/api/auth/register',
        data: {
          'username': username,
          'email': email,
          'password': pasword
        }
      );

      if (user.statusCode == 201) {
        print(user);
        return true;
      }
      return false;

    } catch(error) {
      return error;
    }
  }

  // get token
  Future<dynamic> getToken(String email, String password) async {
    try {

      var response = await Dio().post(
        'http://localhost:6699/huong/api/auth/login',
        data: {
          'username': email,
          'password': password
        }
      );

      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        print(response.data);
        await prefs.setString('token', response.data);
        return true;
      }
      return false;

    } catch (error) {
      return error;
    }
  }

  // get user data
  Future<dynamic> getUser(String token) async {
    try {

      var user = await Dio().get(
        'http://localhost:6699/huong/api/auth/user/$token',
        options: Options(
          headers: {'Authorization': 'Bearer $token'}
        )
      );

      if (user.statusCode == 200 && user.data != '') {
        return json.encode(user.data);
      }

    } catch (error) {
      return error;
    }
  }

}