import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/home_page/receipt_page/comments/comment.dart';
import 'package:menuapp/models/models.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CommentsPage();
  }
}

class _CommentsPage extends State<CommentsPage> {
  List<CommentModel> comentList = [
    CommentModel(
        commentText: "eqweqweqw e qwe qweqweqwe qweqweq qweq ",
        commentDateTime: DateTime.now(),
        userId: "userId",
        user: UserModel(userName: "asd", userPhoto: "assets/images/test.jpg")),
    CommentModel(
        commentText: "eqweqweqw e qwe qweqweqwe qweqweq qweq ",
        commentDateTime: DateTime.now(),
        userId: "userId",
        user: UserModel(userName: "asd", userPhoto: "assets/images/test.jpg")),
    CommentModel(
        commentText: "eqweqweqw e qwe qweqweqwe qweqweq qweq ",
        commentDateTime: DateTime.now(),
        userId: "userId",
        user: UserModel(userName: "asd", userPhoto: "assets/images/test.jpg")),
  ];

  bool isNewCommentLiked = true;
  final TextEditingController _commentFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Text("Comments",
            style: TextStyle(
                fontSize: FontSizeVariables.h1Size,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        TextField(
          textAlign: TextAlign.justify,
          maxLines: null,
          controller: _commentFieldController,
          decoration: InputDecoration(
            labelText: "Write your comment",
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorVariables.primaryColor),
            ),
            labelStyle: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  String commentFieldValue =
                      _commentFieldController.text.trim();
                  if (commentFieldValue.trim().isNotEmpty) {
                    comentList.insert(
                        0,
                        CommentModel(
                            userId: "asd",
                            commentDateTime: DateTime.now(),
                            commentText: commentFieldValue,
                            user: UserModel(
                                userName: "new_user",
                                userPhoto: "assets/images/test.jpg")));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: ColorVariables.primaryColor,
                        duration: const Duration(seconds: 1),
                        content: Text(
                          "Please enter comment text 😒",
                          style:
                              TextStyle(color: ColorVariables.backgroundColor),
                        ),
                      ),
                    );
                  }
                  _commentFieldController.clear();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorVariables.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              ),
              child: Text(
                "Add comment",
                style: TextStyle(color: ColorVariables.backgroundColor),
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: comentList.length,
            itemBuilder: (context, index) {
              final comment = comentList[index];
              return Comment(comment: comment);
            },
          ),
        )
      ],
    );
  }
}
