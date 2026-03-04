class ApiUrls {
  /// ============= base urls ===========>>>
  static const String baseUrl = "https://attendance.merinasib.shop/api/v1";
  static const String imageBaseUrl = "https://attendance.merinasib.shop/api/v1/";
  static const String socketUrl = "https://attendance.merinasib.shop";

  /// ============= all urls ===========>>>

  static const String register = '/auth/signup';
  static const String verifyOtp = '/auth/verify-otp';
  static const String login = '/auth/login';
  static const String resetPassword = '/auth/reset-password';
  static const String forgetPassword = '/auth/forgot-password';
  static const String userMe = '/users/me';
  static const String userUpdate = '/users/profile';

  /// ================= products ===========>>>
  static String products({
    int page = 1,
    int limit = 10,
    String term = '',
    String size = '',
    String category = '',
    String price = '',
    String type = '',
  }) =>
      '/products?term=$term&size=$size&category=$category&price=$price&page=$page&limit=$limit&type=$type';

  static String productDetails(String id) => '/products/$id';
}
