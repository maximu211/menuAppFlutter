// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:menuapp/navigation/navigation_page.dart';
import 'package:menuapp/pages/authorization/log_in_page/log_in_page.dart';
import 'package:menuapp/pages/authorization/text_fields.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/http/auth/user_requests.dart';
import 'package:menuapp/utils/secure_storage.dart';

class VerifyCodePage extends StatefulWidget {
  const VerifyCodePage({super.key});

  @override
  State<VerifyCodePage> createState() => _VerifyCodePage();
}

class _VerifyCodePage extends State<VerifyCodePage> {
  final TextEditingController _emailController = TextEditingController();
  final secureStorage = SecureStorage().storage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                        labelText: "Code",
                        loginFieldController: _emailController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please verification code';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 10),
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
                                          const NavigationPage(), //
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
                              "Verify code",
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
