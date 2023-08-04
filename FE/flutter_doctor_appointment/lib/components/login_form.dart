import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_doctor_appointment/components/button.dart';
import 'package:flutter_doctor_appointment/main.dart';
import 'package:flutter_doctor_appointment/models/auth_model.dart';
import 'package:flutter_doctor_appointment/providers/dio_provider.dart';
import 'package:flutter_doctor_appointment/utils/config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool obsecurePass = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            keyboardType: TextInputType.text,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Username',
              labelText: 'Username',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.person_outlined),
              prefixIconColor: Config.primaryColor
            ),
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            cursorColor: Config.primaryColor,
            obscureText: obsecurePass,
            decoration: InputDecoration(
              hintText: 'Password',
              labelText: 'Password',
              alignLabelWithHint: true,
              prefixIcon: const Icon(Icons.lock_outlined),
              prefixIconColor: Config.primaryColor,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obsecurePass = !obsecurePass;
                  });
                }, 
                icon: obsecurePass ? const Icon(Icons.visibility_off_outlined, color: Colors.black38,) : const Icon(Icons.visibility_outlined, color: Config.primaryColor,)
              )
            ),
          ),
          Config.spaceSmall,
          Consumer<AuthModel>(
            builder: (context, auth, child) {
              return Button(
                width: double.infinity, 
                title: 'Sign In', 
                onPressed: () async {
                  // login here
                  final token = await DioProvider().getToken(
                    _usernameController.text, 
                    _passwordController.text
                  );

                  if (token) {
                    // auth.loginSuccess(); // update login status
                    // redirect to main page

                    // grab user data here
                    final SharedPreferences prefs = await SharedPreferences.getInstance();

                    final tokenValue = prefs.getString('token') ?? '';

                    if (tokenValue.isNotEmpty && tokenValue != '') {
                      // get user data
                      final response = await DioProvider().getUser(tokenValue);
                      
                      print(response);
                      if (response != null) {

                        var jsonResponse = (jsonDecode(response));
                        
                        Map<String, dynamic> userTest = new Map();
                        userTest['userName'] = jsonResponse['userName'];
                        userTest['email'] = jsonResponse['email'];

                        // print('user: $userTest');

                        auth.loginSuccess(userTest, {});
                        MyApp.navigatorKey.currentState!.pushNamed('main');
                      }
                    }

                  }

                }, 
                disable: false
              );
            },
          )
        ],
      ),
    );
  }
}