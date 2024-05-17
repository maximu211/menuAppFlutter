import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/dialog_utils.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';
import 'package:menuapp/pages/common_components/user_row.dart';
import 'package:intl/intl.dart';
import 'package:menuapp/models/models.dart';

class Comment extends StatelessWidget {
  Comment(
      {super.key,
      required this.comment,
      required this.updateFunc,
      required this.delteFunc});

  final CommentModel comment;
  final Function() updateFunc;
  final Function() delteFunc;

  final f = DateFormat('yyyy.MM.dd HH:mm');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            UserRow(
              userId: comment.id,
              textColor: Colors.black,
              image: comment.user.userImage,
              userName: comment.user.userName,
            ),
            comment.isOwner
                ? Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: PopupMenuButton<String>(
                      color: ColorVariables.backgroundColor,
                      icon: Icon(
                        Icons.more_horiz,
                        size: IconSizeVariables.regularSize,
                        color: Colors.black,
                      ),
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'update',
                          child: Text('Update comment'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'delete',
                          child: Text('Delete commnet'),
                        ),
                      ],
                      onSelected: (String value) async {
                        switch (value) {
                          case 'update':
                            updateFunc();
                            break;
                          case 'delete':
                            DialogUtils.showLeavePageDialog(
                              context: context,
                              title: "Delete recipe",
                              description: "Do you want to delete recipe?",
                              okFunc: delteFunc,
                              cancelFunc: () {
                                Navigator.pop(context);
                              },
                            );
                            break;
                        }
                      },
                    ),
                  )
                : Container(),
          ],
        ),
        Text(comment.commentText, textAlign: TextAlign.start),
        const SizedBox(
          height: 10,
        ),
        Text("Posted ${f.format(comment.commentDateTime)}",
            textAlign: TextAlign.start),
        const Divider(
          height: 12,
          color: Colors.black,
          thickness: 2,
        )
      ],
    );
  }
}
