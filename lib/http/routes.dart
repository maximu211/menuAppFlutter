class BaseRoutes {
  static String baseUrl = "https://10.0.2.2:5001/api";
  static String user = "/User";
  static String subscription = "/Subscription";
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
}

class SubscriptionRoutes {
  static String subscribeTo = "/subscribe_to";
  static String unsubscribeFrom = "/unsubscribe_from";
  static String getSubscribers = "/get_subscribers";
  static String getSbuscribedUsers = "/get_subscribed_users";
}
