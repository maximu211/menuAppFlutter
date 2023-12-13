import 'package:flutter/material.dart';
import '../../global_variables/color_variables.dart';
import '../../global_variables/font_size_variables.dart';

class UserRow extends StatelessWidget {
  final String userName;
  final String photoPath;
  final Color textColor;

  UserRow({
    required this.userName,
    required this.photoPath,
    required this.textColor
  });

  @override
  Widget build(BuildContext context) {
    ColorPackage colors = ColorPackage();
    FontSizeVariables fontSize = FontSizeVariables();

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
            child: Image.asset(
              photoPath,
              fit: BoxFit.cover,
              width: 50,
              height: 50,
            ),
          ),
        ),
        Text(
          userName,
          style: TextStyle(
            fontSize: fontSize.regularSize,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
