import 'package:flutter/material.dart';
import 'package:menuapp/log_in_page/text_fields.dart';
import 'package:menuapp/global_variables/color_variables.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ColorPackage colors = ColorPackage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/logo.png', width: 150, color: colors.primary_color),
            const SizedBox(height: 25),
            Text(
              "Sign In",
              style: TextStyle(fontSize: 20, color: colors.primary_color),
            ),
            const SizedBox(height: 25),
            const TextFieldLogin(isPasswordField: false, labelText: "User name"),
            const SizedBox(height: 20),
            const TextFieldLogin(isPasswordField: true, labelText: "Password"),
            const SizedBox(
              height: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/startpage');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary_color,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  ),
                  child: Text(
                    "Log In",
                    style: TextStyle(color: colors.pure_white),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text("Forgot password?",
                        style: TextStyle(fontSize: 15, color: colors.primary_color))),
                TextButton(
                    onPressed: () {},
                    child: Text("Sign Up",
                        style: TextStyle(fontSize: 15, color: colors.primary_color))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
