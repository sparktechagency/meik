class ApiUrls {
  /// ============= base urls ===========>>>
  static const String baseUrl = "https://attendance.merinasib.shop/api/v1";
  static const String imageBaseUrl =
      "https://attendance.merinasib.shop/api/v1/";
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

  static String productDetails(int id) => '/products/$id';

  static String categories({int page = 1, int limit = 10}) => '/sub-categories?page=$page&limit=$limit';
  static String fvrtProduct({int page = 1, int limit = 10}) => '/favourites?page=$page&limit=$limit';
  static String notification({int page = 1, int limit = 10}) => '/notifications?page=$page&limit=$limit';
  static const String productsAdd = '/products';
  static const String sizes = '/sizes';
  static const String colors = '/colors';
  static const String favourites = '/favourites';
  static const String imageURL = 'https://jidian.merinasib.shop/api/v1/s3/pre-signed-url?fileName=newimage.png&primaryPath=UserUploads&field=User_Profile&expiresIn=900';
}
