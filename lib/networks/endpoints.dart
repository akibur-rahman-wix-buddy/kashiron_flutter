 // ignore_for_file: constant_identifier_names

const String url = "https://admin.brobrainapp.com";
const String personImageUrl = "https://thumbs.dreamstime.com/b/portrait-adorable-cheerful-teenage-girl-wonderful-brown-hair-lot-freckles-cheerful-teenager-girl-freckles-264911980.jpg";


final class NetworkConstants {
  NetworkConstants._();
  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "pt";
  static const APP_KEY_VALUE = String.fromEnvironment("APP_KEY_VALUE");
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
}

final class PaymentGateway {
  PaymentGateway._();
  static String gateway(String orderId) => "";
}

final class Endpoints {
  Endpoints._();
  //===================== Auth Part ============================================
  static String signUp() => "/api/register";
  static String logInUrl() => "/api/login";
  static String otpSendApi() => "/api/resend-otp";
  static String otpVerification() => "/api/verify-otp-password";
  static String getHobbyApiLink() => "/api/hobby/get";
  static String postHobbyApiLink() => "/api/hobby/store";
  static String postResendApiLink() => "/api/resend-otp";
  static String passwordUpdate() => "/api/password-update";
  static String otpForgetApiLink() => "verify-otp-password";
  static String forgetPassword() => "/api/forgot-password";
  static String forgetPasswordChangeApiLink() => "/api//set-password";
  static String logout() => "/api/logout";



  ///>>>>>>>>>>>>>>>>>>>>>>>>>>> vip section >>>>>>>>>>>>>>>>>>>>>>>>.

 static String getVipRelationshipList () => "/api/relation/list";
 static String getVipInterestList () => "/api/interest/list";
 static String getVipRelationList () => "/api/relation/list";
 static String createVip () => "/api/vip/create";


 ///>>>>>>>>>>>>>>>>>>>>>>>>> Home section >>>>>>>>>>>>>>>>>>>>>>>>

  static String homeDataApiLink () => "/api/home_data";

 ///>>>>>>>>>>>>>>>>>>>>>>>>> profile section >>>>>>>>>>>>>>>>>>>>>>>>

static String getUserProfileApiLink ()=> "/api/me";
static String updateProfile ()=> "/api/profile/update";
static String changePasswordApiLink()=> "/api/password/change";


}
