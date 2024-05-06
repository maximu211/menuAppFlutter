import 'package:flutter/material.dart';
import 'package:menuapp/pages/common_components/user_row.dart';
import 'package:intl/intl.dart';
import 'package:menuapp/http/DTOs/models.dart';

class Comment extends StatelessWidget {
  Comment(
      {super.key,
      required this.comment});

  final CommentModel comment;

  final f = DateFormat('yyyy.MM.dd HH:mm');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            UserRow(
              textColor: Colors.black,
              image: comment.user.userPhoto,
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