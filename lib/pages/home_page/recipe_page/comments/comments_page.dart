// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/http/DTOs/dtos.dart';
import 'package:menuapp/http/comment_requests/comment_requests.dart';
import 'package:menuapp/models/models.dart';
import 'package:menuapp/pages/home_page/recipe_page/comments/comment.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({super.key, required this.recipeId});
  final String recipeId;

  @override
  State<StatefulWidget> createState() {
    return _CommentsPage();
  }
}

class _CommentsPage extends State<CommentsPage> {
  late Future<CommentModelDto> _commentsFuture;
  final TextEditingController _commentFieldController = TextEditingController();
  final GlobalKey<FormState> _commentFieldKey = GlobalKey<FormState>();
  final TextEditingController _editCommentController = TextEditingController();
  final GlobalKey<FormState> _commentEditFieldKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  void _showEditCommentSheet(CommentModel comment) {
    _editCommentController.text = comment.commentText;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: _commentEditFieldKey,
                    child: TextFormField(
                      controller: _editCommentController,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Please enter a comment";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Edit your comment",
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorVariables.primaryColor),
                        ),
                        labelStyle: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (_commentEditFieldKey.currentState!.validate()) {
                            await CommentRequests.updateComment(
                                comment.id, _editCommentController.text.trim());
                            Navigator.pop(context);
                            _loadComments();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorVariables.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: Text(
                          "Update comment",
                          style:
                              TextStyle(color: ColorVariables.backgroundColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _loadComments() async {
    _commentsFuture = CommentRequests.getCommentsByRecipeId(widget.recipeId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            "Comments",
            style: TextStyle(
              fontSize: FontSizeVariables.h1Size,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Form(
            key: _commentFieldKey,
            child: TextFormField(
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Please enter comment";
                } else {
                  return null;
                }
              },
              textAlign: TextAlign.justify,
              maxLines: null,
              controller: _commentFieldController,
              decoration: InputDecoration(
                labelText: "Write your comment",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorVariables.primaryColor),
                ),
                labelStyle: const TextStyle(color: Colors.black),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  _addComment();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorVariables.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: Text(
                  "Add comment",
                  style: TextStyle(color: ColorVariables.backgroundColor),
                ),
              ),
            ],
          ),
          FutureBuilder<CommentModelDto>(
            future: _commentsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final commentList = snapshot.data!.commentList;
                return SingleChildScrollView(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: commentList.length,
                    itemBuilder: (context, index) {
                      final comment = commentList[index];
                      return Comment(
                        comment: comment,
                        delteFunc: () {
                          CommentRequests.deleteComment(comment.id);
                          Navigator.pop(context);
                          setState(() {
                            _loadComments();
                          });
                        },
                        updateFunc: () {
                          _showEditCommentSheet(comment);
                        },
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void _addComment() async {
    if (_commentFieldKey.currentState!.validate()) {
      await CommentRequests.leaveComment(
          widget.recipeId, _commentFieldController.text.trim());
      setState(() {
        _loadComments();
      });
      _commentFieldController.text = "";
    }
  }
}
