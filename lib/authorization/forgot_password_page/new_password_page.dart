import 'package:flutter/material.dart';
import 'package:menuapp/authorization/sign_in_page/sign_in_page.dart';
import 'package:menuapp/authorization/text_fields.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';

class NewPasswordPage extends StatelessWidget {
  ColorPackage colors = ColorPackage();
  FontSizeVariables fontSize = FontSizeVariables();
  IconSizeVariables iconSizeVariables = IconSizeVariables();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
                Image.asset('assets/images/logo.png', width: 150, color: Colors.white),
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
                        String repeatPasswordText = _repeatPasswordController.text;
                        if ((passwordText.isNotEmpty && repeatPasswordText.isNotEmpty) &&
                            (passwordText == repeatPasswordText)) {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => const LoginPage()));
                        } else {
                          String textError;
                          if (passwordText != repeatPasswordText) {
                            textError = "The passwords you entered are not the same";
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: colors.primary_color,
                              duration: const Duration(seconds: 1),
                              content: Text(
                                "Please enter all fields 😒",
                                style: TextStyle(color: colors.background_color),
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary_color,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                      ),
                      child: Text(
                        "Save new password",
                        style: TextStyle(color: colors.background_color),
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
