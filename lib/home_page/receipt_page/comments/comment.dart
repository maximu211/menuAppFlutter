import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';
import 'package:menuapp/home_page/components/user_row.dart';
import 'package:intl/intl.dart';

class Comment extends StatefulWidget{
  Comment({super.key, required this.isLiked, required this.commentText, required this.commentDateTime});

  bool isLiked;
  String commentText;
  DateTime commentDateTime;

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  final ColorPackage colors = ColorPackage();

  final FontSizeVariables fontSize = FontSizeVariables();

  final IconSizeVariables iconSize = IconSizeVariables();

  final f = new DateFormat('yyyy.MM.dd HH:mm');
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
      Row(children: [
        UserRow(textColor: Colors.black, photoPath: "assets/images/test.jpg", userName: "UserName",),
        const SizedBox(width: 10,),
        Icon(widget.isLiked ? Icons.thumb_up : Icons.thumb_down),
      ],),
      Text(widget.commentText, textAlign: TextAlign.start),
      const SizedBox(height: 10,),
      Text("Posted ${f.format(widget.commentDateTime)}", textAlign: TextAlign.start),
      const Divider(height: 12, color: Colors.black, thickness: 2,)
    ],);
  }
}