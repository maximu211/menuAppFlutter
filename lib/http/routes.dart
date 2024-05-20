class BaseRoutes {
  static String baseUrl = "https://10.0.2.2:5001/api";
  static String user = "/User";
  static String subscription = "/Subscription";
  static String recipe = "/Recipe";
  static String comment = "/Comment";
  static String search = "/Search";
}

class SearchRoutes {
  static String search = "/search";
}

class UserRoutes {
  static String logIn = "/log_in";
  static String logOut = "/log_out";
  static String refreshToken = "/refresh_token";
  static String registerEmail = "/register_email";
  static String verifyEmail = "/verify_email";
  static String updateEmailAndSendCode = "/update_email_and_send_code";
  static String resendConfirmationCode = "/resend_confirmation_code";
  static String sendCodeToRecoverPassword =
      "/send_verification_code_to_recover_password";
  static String verifyPasswordRecover = "/verify_password_recover";
  static String setNewPassword = "/set_new_password";
  static String registerUser = "/register_user";
  static String setUserImage = "/set_user_image";
  static String getUserImage = "/get_user_image";
  static String userPage = "/get_page_data";
}

class SubscriptionRoutes {
  static String subscribeTo = "/subscribe_to";
  static String unsubscribeFrom = "/unsubscribe_from";
  static String getSubscribers = "/get_subscribers";
  static String getSbuscribedUsers = "/get_subscribed_users";
}

class RecipeRoutes {
  static String createRecipe = "/create_recipe";
  static String getRecipesByUserId = "/get_recipes_by_userId";
  static String getRecipesBySubs = "/get_recipes_by_subscriptions";
  static String getSavedRecipes = "/get_user_saved_recipes";
  static String deleteRecipe = "/delete_recipe";
  static String updateRecipe = "/update_recipe";
  static String likeRecipe = "/like_recipe";
  static String saveRecipe = "/save_recipe";
  static String dislikeRecipe = "/dislike_recipe";
  static String deleteFromSaved = "/delete_recipe_from_saved";
  static String getRecipeDetails = "/get_recipe_details";
  static String getRecipeById = "/get_recipe_by_id";
}

class CommentRoutes {
  static String leaveComment = "/leave_comment";
  static String getCommentsByRecipeId = "/get_comments_by_recipeId";
  static String deleteComment = "/delete_comment";
  static String updateComment = "/update_comment";
}
