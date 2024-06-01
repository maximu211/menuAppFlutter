import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/pages/authorization/text_fields.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';

class RegisterUserPage extends StatefulWidget {
  const RegisterUserPage({Key? key}) : super(key: key);

  @override
  State<RegisterUserPage> createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
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
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color.fromARGB(150, 229, 238, 230),
              ),
              child: Form(
                key: _formKey,
                onChanged: () => clearErrors(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png',
                        width: 150, color: Colors.black),
                    const SizedBox(height: 25),
                    Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: FontSizeVariables.h1Size,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 25),
                    TextFieldLogin(
                      isPasswordField: false,
                      labelText: "User Name",
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
                      isPasswordField: false,
                      labelText: "Password",
                      loginFieldController: _emailController,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Pelase input password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldLogin(
                      isPasswordField: true,
                      labelText: "Repeat Password",
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
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisterUserPage(), //
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                          ),
                          child: Text(
                            "Sign Up",
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
