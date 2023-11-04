import 'package:flutter/material.dart';
import 'package:menuapp/authorization/forgot_password_page/new_password_page.dart';
import 'package:menuapp/authorization/text_fields.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';

class ConfirmationCodePage extends StatefulWidget {

  ConfirmationCodePage({super.key});

  @override
  State<ConfirmationCodePage> createState() => _ConfirmationCodePageState();
}

class _ConfirmationCodePageState extends State<ConfirmationCodePage> {
  ColorPackage colors = ColorPackage();
  FontSizeVariables fontSize = FontSizeVariables();
  IconSizeVariables iconSizeVariables = IconSizeVariables();

  final TextEditingController _codeController = TextEditingController();

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
                  const Text(
                    "Enter code confirmation code",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 25),
                  TextFieldLogin(
                    //validationKey: _formKey,
                    isPasswordField: false,
                    labelText: "Confirmation code",
                    loginFieldController: _codeController,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Please enter code';
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
                          if(_formKey.currentState!.validate()){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => NewPasswordPage()));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.primary_color,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                        ),
                        child: Text(
                          "Verify code",
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
