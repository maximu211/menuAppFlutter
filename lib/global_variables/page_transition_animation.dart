import 'package:flutter/material.dart';
import 'package:menuapp/http/DTOs/dtos.dart';
import 'package:menuapp/models/models.dart';
import 'package:menuapp/pages/add_page/add_page.dart';
import 'package:menuapp/pages/add_page/form_components/instruction_edit/editing_components/step_update_page.dart';
import 'package:menuapp/pages/home_page/recipe_page/recipe_page.dart';

class NavigationService {
  static Route createRecipePageRoute(CardRecipeModel cardRecipe) {
    return _createPageRoute(
      page: RecipePage(cardRecipe: cardRecipe),
    );
  }

  static Route createAddPageRoute(
      RecipeNotifier fullRecipe, bool isUpdate, String recipeId) {
    return _createPageRoute(
      page: AddPage(recipe: fullRecipe, isUpdate: isUpdate, recipeId: recipeId),
    );
  }

  static Route createEditStepPageRoute(
      RecipeDescriptionElement step, int stepNum) {
    return _createPageRoute(
      page: StepUpdatePage(step: step, stepNum: stepNum),
    );
  }

  static Route _createPageRoute({required Widget page}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
