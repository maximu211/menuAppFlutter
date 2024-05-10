import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';

class UserRow extends StatelessWidget {
  final String userName;
  final Uint8List image;
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
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
          child: ClipOval(
            child: Image.memory(
              image,
              fit: BoxFit.cover,
              width: 50,
              height: 50,
            ),
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
    );
  }
}
