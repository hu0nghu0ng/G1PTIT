import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier {
  bool _isLogin = false;

  Map<String, dynamic> user = {}; // update user details when login

  Map<String, dynamic> appointment = {}; // update upcaoming appointment when login

  List<Map<String, dynamic>> favDoc = []; // get lastest favourite doctor

  List<dynamic> _fav = []; // get all fav doctor id in list

  bool get isLogin {
    return _isLogin;
  }

  List<dynamic> get getFav {
    return _fav;
  }

  Map<String, dynamic> get getUser {
    return user;
  }

  Map<String, dynamic> get getAppointment {
    return appointment;
  }

  void loginSuccess(Map<String, dynamic> userData, Map<String, dynamic> appointmentInfo) {
    _isLogin = true;

    // update all these data when login
    user = userData;
    appointment = appointmentInfo;

    notifyListeners();

  }

}