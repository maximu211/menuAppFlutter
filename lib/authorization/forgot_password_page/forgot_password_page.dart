import 'package:flutter/material.dart';
import 'package:menuapp/authorization/forgot_password_page/confirmation_code_page.dart';
import 'package:menuapp/authorization/text_fields.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';

class ForgotPasswordPage extends StatefulWidget {

  ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  ColorPackage colors = ColorPackage();
  FontSizeVariables fontSize = FontSizeVariables();
  IconSizeVariables iconSizeVariables = IconSizeVariables();

  TextEditingController _eMailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void clearErrors() {
    setState(() {
      _formKey.currentState?.validate();
    });
  }

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
          child: Form(
            key: _formKey,
            onChanged: () => clearErrors(),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/logo.png', width: 150, color: Colors.white),
                  const SizedBox(height: 25),
                  Text(
                    "Forgot Password?",
                    style: TextStyle(fontSize: fontSize.h1Size, color: Colors.white),
                  ),
                  Text(
                    "Enter your Email and we will send you a verification code",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: fontSize.h2Size, color: Colors.white),
                  ),
                  const SizedBox(height: 25),
                  TextFieldLogin(
                    isPasswordField: false,
                    labelText: "Email",
                    loginFieldController: _eMailController,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Please enter your Email';
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
                          if (_formKey.currentState!.validate()){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => ConfirmationCodePage()));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.primary_color,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                        ),
                        child: Text(
                          "Send Code",
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
      ),
    ]);
  }
}
