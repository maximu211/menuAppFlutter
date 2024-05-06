import 'package:flutter/material.dart';
import 'package:menuapp/pages/authorization/log_in_page/log_in_page.dart';
import 'package:menuapp/pages/authorization/text_fields.dart';
import 'package:menuapp/global_variables/color_variables.dart';

class NewPasswordPage extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  NewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned.fill(
          child: Image.asset(
        "assets/images/background_image.png",
        fit: BoxFit.cover,
      )),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/logo.png',
                    width: 150, color: Colors.white),
                const SizedBox(height: 25),
                const Text(
                  "Enter your new password",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(height: 25),
                TextFieldLogin(
                  isPasswordField: true,
                  labelText: "New password",
                  loginFieldController: _passwordController,
                  validator: (value) {
                    if (value == null || value.isNotEmpty) {
                      return 'Please enter new password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                TextFieldLogin(
                  //validationKey: _formKey,
                  isPasswordField: true,
                  labelText: "Repeat new password",
                  loginFieldController: _repeatPasswordController,
                  validator: (value) {
                    if (value == null || value.isNotEmpty) {
                      return 'Please enter repeated new password';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        String passwordText = _passwordController.text;
                        String repeatPasswordText =
                            _repeatPasswordController.text;
                        if ((passwordText.isNotEmpty &&
                                repeatPasswordText.isNotEmpty) &&
                            (passwordText == repeatPasswordText)) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        } else {
                          //String textError;
                          if (passwordText != repeatPasswordText) {}
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: ColorVariables.primaryColor,
                              duration: const Duration(seconds: 1),
                              content: Text(
                                "Please enter all fields 😒",
                                style: TextStyle(
                                    color: ColorVariables.backgroundColor),
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorVariables.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                      ),
                      child: Text(
                        "Save new password",
                        style: TextStyle(color: ColorVariables.backgroundColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
