import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/pages/user_page/user_page.dart';

class UserRow extends StatelessWidget {
  final String userName;
  final Uint8List? image;
  final Color textColor;
  final String userId;

  const UserRow(
      {super.key,
      required this.userName,
      required this.image,
      required this.textColor,
      required this.userId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(
              body: UserPage(
                userId: userId,
                isOpenedFromNavBar: false,
              ),
            ),
          ),
        );
      },
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: image != null ? Colors.black : ColorVariables.primaryColor,
            ),
            child: image != null
                ? ClipOval(
                    child: Image.memory(
                      image!,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                  )
                : Icon(
                    Icons.person,
                    color: ColorVariables.backgroundColor,
                    size: 40,
                  ),
          ),
          Text(
            userName,
            style: TextStyle(
              fontSize: FontSizeVariables.regularSize,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
