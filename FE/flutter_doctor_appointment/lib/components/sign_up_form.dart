import 'package:flutter/material.dart';
import 'package:flutter_doctor_appointment/components/button.dart';
import 'package:flutter_doctor_appointment/main.dart';
import 'package:flutter_doctor_appointment/models/auth_model.dart';
import 'package:flutter_doctor_appointment/providers/dio_provider.dart';
import 'package:flutter_doctor_appointment/utils/config.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool obsecurePass = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.text,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Username',
              labelText: 'Username',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.person_outlined),
              prefixIconColor: Config.primaryColor
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Email Address',
              labelText: 'Email',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.email_outlined),
              prefixIconColor: Config.primaryColor
            ),
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _passController,
            keyboardType: TextInputType.visiblePassword,
            cursorColor: Config.primaryColor,
            obscureText: obsecurePass,
            decoration: InputDecoration(
              hintText: 'Password',
              labelText: 'Password',
              alignLabelWithHint: true,
              prefixIcon: const Icon(Icons.lock_outline),
              prefixIconColor: Config.primaryColor,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obsecurePass = !obsecurePass;
                  });
                }, 
                icon: obsecurePass ? const Icon(Icons.visibility_off_outlined) : const Icon(Icons.visibility_outlined)
              )
            ),
          ),
          Config.spaceSmall,
          Consumer<AuthModel>(
            builder: (context, auth, child) {
              return Button(
                width: double.infinity, 
                title: 'Sign Up', 
                onPressed: () async {
                  

                  if (_formKey.currentState!.validate()) {
                    print('object');
                    final userRegistration = await DioProvider().registerUser(
                      _nameController.text, 
                      _emailController.text, 
                      _passController.text
                    );
                    if (userRegistration) {
                      final token = await DioProvider().getToken(_nameController.text, _passController.text);

                      if (token) {
                        auth.loginSuccess({}, {});

                        // redirect to main page
                        MyApp.navigatorKey.currentState!.pushNamed('main');

                      } else {
                        print('Register Not Successful');
                      }
                    }
                  }

                  // if register success, proceed to login
                  
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