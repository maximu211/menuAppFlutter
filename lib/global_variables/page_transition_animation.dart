import 'package:flutter/material.dart';
import 'package:menuapp/pages/add_page/add_page.dart';
import 'package:menuapp/pages/add_page/form_components/instruction_edit/editing_components/step_update_page.dart';
import 'package:menuapp/pages/home_page/recipe_page/recipe_page.dart';

Route createRoute({
  dynamic cardRecipe,
  dynamic step,
  dynamic stepNum,
  dynamic fullRecipe,
  required String pageType,
}) {
  late Widget destinationPage;

  if (pageType == 'recipePage') {
    destinationPage = RecipePage(cardRecipe: cardRecipe);
  } else if (pageType == 'addPage') {
    destinationPage =  AddPage(recipe: fullRecipe);
  } else if (pageType == 'editStepPage') {
    destinationPage = StepUpdatePage(step: step, stepNum: stepNum);
  }

  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => destinationPage,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
