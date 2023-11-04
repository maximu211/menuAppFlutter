import 'package:flutter/material.dart';
import 'package:menuapp/authorization/forgot_password_page/forgot_password_page.dart';
import 'package:menuapp/authorization/sign_up_page/sign_up_page.dart';
import 'package:menuapp/authorization/text_fields.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ColorPackage colors = ColorPackage();
  final FontSizeVariables fontSize = FontSizeVariables();
  final IconSizeVariables iconSize = IconSizeVariables();

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                onChanged: () => clearErrors(),
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/logo.png', width: 150, color: Colors.white),
                    const SizedBox(height: 25),
                    Text(
                      "Sign In",
                      style: TextStyle(fontSize: fontSize.h1Size, color: Colors.white),
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
                    const SizedBox(
                      height: 50,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushNamed(context, '/startpage');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.primary_color,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          ),
                          child: Text(
                            "Log In",
                            style: TextStyle(color: colors.background_color),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
                            },
                            child: Text("Forgot password?",
                                style: TextStyle(
                                    fontSize: fontSize.regularSize, color: colors.primary_color))),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => SignUpPage()));
                            },
                            child: Text("Sign Up",
                                style: TextStyle(
                                    fontSize: fontSize.regularSize, color: colors.primary_color))),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
