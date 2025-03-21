class API {

  // https://stocksapi.waafi.com/api/user/iban
  // static const String _domain = "10.23.2.100";
  // static const String _port = "8010";
  // static const String _baseUrl = "http://$_domain:$_port/api";
  static const String _productionDomain = "stocksapi.waafi.com";
  static const String _baseUrl = "https://$_productionDomain/api";

  // User
  static const String _baseUrlUser = "$_baseUrl/user";
  static String login = "$_baseUrlUser/login";
  static String loginWithCredentials = "$_baseUrlUser/loginWithCredentials";
  static String verifyLoginOTP = "$_baseUrlUser/login-otp/verify";
  static String accountTransactionsBy({required String endDate}) =>
      "$verifyLoginOTP?type=$endDate";

}
