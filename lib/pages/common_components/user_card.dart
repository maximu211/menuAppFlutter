import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/models/models.dart';
import 'package:menuapp/pages/common_components/user_row.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.userModel,
  });

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorVariables.primaryColor,
          boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 5)]),
      child: UserRow(
          userId: "asd",
          userName: userModel.userName,
          image: userModel.userImage,
          textColor: ColorVariables.backgroundColor),
    );
  }
}
