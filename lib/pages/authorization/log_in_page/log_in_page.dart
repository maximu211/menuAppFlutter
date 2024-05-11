// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:menuapp/navigation/navigation_page.dart';
import 'package:menuapp/pages/authorization/forgot_password_page/forgot_password_page.dart';
import 'package:menuapp/pages/authorization/register_pages/register_email_page.dart';
import 'package:menuapp/pages/authorization/text_fields.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/http/user_requests/user_requests.dart';
import 'package:menuapp/utils/secure_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final secureStorage = SecureStorage().storage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String errorMessage = "";

  void clearErrors() {
    setState(() {
      _formKey.currentState?.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Image.asset(
          "assets/images/background_image.png",
          fit: BoxFit.cover,
        )),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color.fromARGB(150, 229, 238, 230),
                ),
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  onChanged: () => clearErrors(),
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/logo.png',
                          width: 150, color: Colors.black),
                      const SizedBox(height: 25),
                      Text(
                        "Sign In",
                        style: TextStyle(
                            fontSize: FontSizeVariables.h1Size,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 25),
                      TextFieldLogin(
                        isPasswordField: false,
                        labelText: "User name",
                        loginFieldController: _userNameController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter user name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFieldLogin(
                        isPasswordField: true,
                        labelText: "Password",
                        loginFieldController: _passwordController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      Text(errorMessage,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 250, 4, 0))),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final result = await UserRequest.logIn(
                                  _passwordController.text,
                                  _userNameController.text,
                                );
                                if (result.success) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const NavigationPage(),
                                    ),
                                  );
                                  await secureStorage.write(
                                    key: "AccessToken",
                                    value: result.accessToken,
                                  );
                                  await secureStorage.write(
                                    key: "RefreshToken",
                                    value: result.refreshToken,
                                  );
                                } else {
                                  setState(() {
                                    errorMessage = result.message;
                                  });
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                            ),
                            child: Text(
                              "Log In",
                              style: TextStyle(
                                  color: ColorVariables.backgroundColor),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPasswordPage()));
                              },
                              child: Text("Forgot password?",
                                  style: TextStyle(
                                      fontSize: FontSizeVariables.regularSize,
                                      color: Colors.black))),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterEmailPage()));
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontSize: FontSizeVariables.regularSize,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
