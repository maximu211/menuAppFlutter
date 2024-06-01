// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:menuapp/pages/authorization/log_in_page/log_in_page.dart';
import 'package:menuapp/pages/authorization/register_pages/verify_code_page.dart';
import 'package:menuapp/pages/authorization/text_fields.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/http/user_requests/user_requests.dart';
import 'package:menuapp/utils/secure_storage.dart';

class RegisterEmailPage extends StatefulWidget {
  const RegisterEmailPage({super.key});

  @override
  State<RegisterEmailPage> createState() => _RegisterEmailPage();
}

class _RegisterEmailPage extends State<RegisterEmailPage> {
  final TextEditingController _emailController = TextEditingController();
  final secureStorage = SecureStorage().storage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
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
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 25),
                      Text(
                        "Input your email to send verify code",
                        style: TextStyle(
                            fontSize: FontSizeVariables.h1Size,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 25),
                      TextFieldLogin(
                        isPasswordField: false,
                        labelText: "Email",
                        loginFieldController: _emailController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter Email';
                          } else if (!_isValidEmail(value)) {
                            return 'Please enter a valid Email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final result = await UserRequest.registerEmail(
                                    _emailController.text);
                                if (result.success) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const VerifyCodePage(
                                              isRecoverPasswordPage: false), //
                                    ),
                                  );
                                  await secureStorage.write(
                                    key: "AuthToken",
                                    value: result.authToken,
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                            ),
                            child: Text(
                              "Verify email",
                              style: TextStyle(
                                  color: ColorVariables.backgroundColor),
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          child: Text("Already have an account? Log in!",
                              style: TextStyle(
                                  fontSize: FontSizeVariables.regularSize,
                                  color: Colors.black)))
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
