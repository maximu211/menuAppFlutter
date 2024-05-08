import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/pages/home_page/recipe_page/comments/comment.dart';
import 'package:menuapp/models/models.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CommentsPage();
  }
}

class _CommentsPage extends State<CommentsPage> {
  late BinaryFileReader binaryFileReader;
  late Uint8List binaryData;
  late Future<List<CommentModel>> comentList;
  @override
  void initState() {
    super.initState();
    comentList = loadData();
  }

  Future<List<CommentModel>> loadData() async {
    var data = await rootBundle.load('assets/images/recipe_images/1.jpg');
    setState(() => binaryData = data.buffer.asUint8List());
    return [
      CommentModel(
        commentText: "eqweqweqw e qwe qweqweqwe qweqweq qweq ",
        commentDateTime: DateTime.now(),
        user: UserModel(userName: "asd", userImage: binaryData, userId: '12'),
        isOwner: false,
      ),
      CommentModel(
        commentText: "eqweqweqw e qwe qweqweqwe qweqweq qweq ",
        commentDateTime: DateTime.now(),
        user: UserModel(
          userName: "asd",
          userImage: binaryData,
          userId: "userId",
        ),
        isOwner: false,
      ),
      CommentModel(
        commentText: "eqweqweqw e qwe qweqweqwe qweqweq qweq ",
        commentDateTime: DateTime.now(),
        isOwner: false,
        user: UserModel(
          userName: "asd",
          userImage: binaryData,
          userId: "userId",
        ),
      ),
    ];
  }

  bool isNewCommentLiked = true;
  final TextEditingController _commentFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
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
                      comentList = loadData().then((list) {
                        return [
                          CommentModel(
                            isOwner: true,
                            commentDateTime: DateTime.now(),
                            commentText: commentFieldValue,
                            user: UserModel(
                              userName: "new_user",
                              userImage: binaryData,
                              userId: "asd",
                            ),
                          ),
                          ...list,
                        ];
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: ColorVariables.primaryColor,
                          duration: const Duration(seconds: 1),
                          content: Text(
                            "Please enter comment text 😒",
                            style: TextStyle(
                              color: ColorVariables.backgroundColor,
                            ),
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
          FutureBuilder(
            future: comentList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return SingleChildScrollView(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final comment = snapshot.data![index];
                      return Comment(comment: comment);
                    },
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
