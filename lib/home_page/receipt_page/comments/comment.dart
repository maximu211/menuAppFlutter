import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';
import 'package:menuapp/home_page/components/user_row.dart';
import 'package:intl/intl.dart';
import 'package:menuapp/models/models.dart';

class Comment extends StatelessWidget {
  Comment(
      {super.key,
      required this.comment});

  CommentModel comment;

  final ColorPackage colors = ColorPackage();
  final FontSizeVariables fontSize = FontSizeVariables();
  final IconSizeVariables iconSize = IconSizeVariables();

  final f = new DateFormat('yyyy.MM.dd HH:mm');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            UserRow(
              textColor: Colors.black,
              photoPath: comment.user.userPhoto,
              userName: comment.user.userName,
            ),
          ],
        ),
        Text(comment.commentText, textAlign: TextAlign.start),
        const SizedBox(
          height: 10,
        ),
        Text("Posted ${f.format(comment.commentDateTime)}", textAlign: TextAlign.start),
        const Divider(
          height: 12,
          color: Colors.black,
          thickness: 2,
        )
      ],
    );
  }
}
