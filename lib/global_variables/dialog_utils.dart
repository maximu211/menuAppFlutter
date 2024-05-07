import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';

class DialogUtils {
  static void showLeavePageDialog(
      {required BuildContext context,
      required String title,
      required String description,
      required Function() okFunc,
      required Function() cancelFunc}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: ColorVariables.primaryColor,
        title: Text(
          title,
          style: TextStyle(
            color: ColorVariables.backgroundColor,
            fontSize: FontSizeVariables.h1Size,
          ),
        ),
        content: Text(
          description,
          style: TextStyle(
            color: ColorVariables.backgroundColor,
            fontSize: FontSizeVariables.regularSize,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: okFunc,
            child: Text(
              "Ok",
              style: TextStyle(
                color: ColorVariables.backgroundColor,
                fontSize: FontSizeVariables.regularSize,
              ),
            ),
          ),
          TextButton(
            onPressed: cancelFunc,
            child: Text(
              "Cancel",
              style: TextStyle(
                color: ColorVariables.backgroundColor,
                fontSize: FontSizeVariables.regularSize,
              ),
            ),
          )
        ],
      ),
    );
  }

  static void showMessage(
      {required BuildContext context, required String text}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: ColorVariables.primaryColor,
        title: Text(
          text,
          style: TextStyle(
            color: ColorVariables.backgroundColor,
            fontSize: FontSizeVariables.h1Size,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Ok",
              style: TextStyle(
                color: ColorVariables.backgroundColor,
                fontSize: FontSizeVariables.regularSize,
              ),
            ),
          )
        ],
      ),
    );
  }
}
