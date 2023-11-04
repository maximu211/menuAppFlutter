import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';
import 'package:menuapp/home_page/receipt_page/comments/comment.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CommentsPage();
  }
}

class _CommentsPage extends State<CommentsPage> {
  final ColorPackage colors = ColorPackage();
  final FontSizeVariables fontSize = FontSizeVariables();
  final IconSizeVariables iconSize = IconSizeVariables();

  final List<bool> _selections = [true, false]; // Список для відстеження стану кнопок
  bool isNewCommentLiked = true;
  final TextEditingController _commentFieldController = TextEditingController();

  List<Comment> commentsList = [
    Comment(
        isLiked: true,
        commentDateTime: DateTime(2021, 20, 2),
        commentText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ..."),
    Comment(
        isLiked: false,
        commentDateTime: DateTime(2021, 21, 2),
        commentText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ..."),
    Comment(
        isLiked: false,
        commentDateTime: DateTime(2021, 23, 2),
        commentText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ..."),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          "Comments",
          style: TextStyle(fontSize: fontSize.h1Size),
        ),
        TextField(
          textAlign: TextAlign.justify,
          maxLines: null,
          controller: _commentFieldController,
          decoration: InputDecoration(
            labelText: "Write your comment",
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colors.primary_color),
            ),
            labelStyle: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ToggleButtons(
              isSelected: _selections,
              selectedColor: colors.primary_color, // Колір кнопок при виборі
              fillColor: Colors.transparent,
              renderBorder: false,
              onPressed: (int index) {
                setState(() {
                  // Перевіряємо, чи можна натискати кнопку
                  if ((index == 0 && !_selections[0]) || (index == 1 && !_selections[1])) {
                    _selections[index] = !_selections[index];
                    _selections[(index + 1) % 2] = !_selections[(index + 1) % 2];
                    if (index == 0) {
                      isNewCommentLiked = true;
                    } else if (index == 1) {
                      isNewCommentLiked = false;
                    }
                  }
                });
              },
              children: const <Widget>[
                Icon(Icons.thumb_up),
                Icon(Icons.thumb_down),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  String commentFieldValue = _commentFieldController.text;
                  if (commentFieldValue.trim().isNotEmpty) {
                    commentsList.insert(
                        0,
                        Comment(
                            isLiked: isNewCommentLiked,
                            commentDateTime: DateTime.now(),
                            commentText: commentFieldValue));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: colors.primary_color,
                        duration: Duration(seconds: 1),
                        content: Text(
                          "Please enter comment text 😒",
                          style: TextStyle(color: colors.background_color),
                        ),
                      ),
                    );
                  }
                  _commentFieldController.clear();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary_color,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              ),
              child: Text(
                "Add comment",
                style: TextStyle(color: colors.background_color),
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          child: Column(
            children: commentsList,
          ),
        )
      ],
    );
  }
}
