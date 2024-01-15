import 'package:flutter/material.dart';
import 'package:menuapp/authorization/sign_in_page/sign_in_page.dart';
import 'package:menuapp/global_variables/color_variables.dart';

import 'package:menuapp/authorization/text_fields.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void clearErrors() {
    setState(() {
      _formKey.currentState?.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_image.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                key: _formKey,
                onChanged: () => clearErrors(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png',
                        width: 150, color: Colors.white),
                    const SizedBox(height: 25),
                    Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: FontSizeVariables.h1Size,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 25),
                    TextFieldLogin(
                      //validationKey: UniqueKey(),
                      isPasswordField: false,
                      labelText: "E-Mail",
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
                      //validationKey: UniqueKey(),
                      isPasswordField: false,
                      labelText: "User Name",
                      loginFieldController: _emailController,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Please enter EMail';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldLogin(
                      //validationKey: UniqueKey(),
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorVariables.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                          ),
                          child: Text(
                            "Register",
                            style: TextStyle(
                                color: ColorVariables.backgroundColor),
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
      ),
    ]);
  }
}
