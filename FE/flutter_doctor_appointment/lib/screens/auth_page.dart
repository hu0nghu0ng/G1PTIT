import 'package:flutter/material.dart';
import 'package:flutter_doctor_appointment/components/login_form.dart';
import 'package:flutter_doctor_appointment/components/sign_up_form.dart';
import 'package:flutter_doctor_appointment/utils/config.dart';
import 'package:flutter_doctor_appointment/utils/text.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  bool isSignIn = true;

  @override
  Widget build(BuildContext context) {

    Config().init(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15, 
          vertical: 15
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppText.enText['welcome_text'].toString(),
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold
                ),
              ),
              Config.spaceSmall,
              Text(
                isSignIn ? AppText.enText['signIn_text'].toString() : AppText.enText['register_text'].toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
              Config.spaceSmall,
              isSignIn ? LoginForm() : SignUpForm(),
              Config.spaceSmall,
            ],
          )
        ),
      ),
    );
  }
}