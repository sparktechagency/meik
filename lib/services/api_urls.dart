class ApiUrls {
  /// ============= base urls ===========>>>
  static const String baseUrl = "https://attendance.merinasib.shop/api/v1";
  static const String imageBaseUrl = "https://minio.merinasib.shop/ebfmart";
  static const String socketUrl = "https://attendance.merinasib.shop/";

  /// ============= all urls ===========>>>

  static const String register = '/auth/signup';
  static const String verifyOtp = '/auth/verify-otp';
  static const String login = '/auth/login';
  static const String resetPassword = '/auth/reset-password';
  static const String forgetPassword = '/auth/forgot-password';
  static const String userMe = '/users/me';
  static const String userUpdate = '/users/profile';
  static const String preNext = '/orders/checkout/preview';
  static const String checkoutExecute = '/orders/checkout/execute';

  /// ================= products ===========>>>
  static String products({
    int page = 1,
    int limit = 10,
    String term = '',
    String size = '',
    String category = '',
    String price = '',
    String type = '',
    String? status,
  }) {
    String url = '/products?term=$term&size=$size&category=$category&price=$price&page=$page&limit=$limit&type=$type';

    if (status != null && status.isNotEmpty) {
      url += '&status=$status';
    }

    return url;
  }

  static String productDetails(int id) => '/products/$id';
  static String checkout(int id) => '/orders/checkout-info/$id';

  static String categories({int page = 1, int limit = 10}) => '/sub-categories?page=$page&limit=$limit';
  static String fvrtProduct({int page = 1, int limit = 10}) => '/favourites?page=$page&limit=$limit';
  static String phurcasesProduct({int page = 1, int limit = 10}) => '/orders/purchases?page=$page&limit=$limit';
  static String transections({int page = 1, int limit = 10}) => '/transections?page=$page&limit=$limit';
  static String salesProduct({int page = 1, int limit = 10}) => '/orders/sales?page=$page&limit=$limit';
  static String notification({int page = 1, int limit = 10}) => '/notifications?page=$page&limit=$limit';
  static String conversations({int page = 1, int limit = 50}) => '/conversations?page=$page&limit=$limit';
  static String inbox({String conID = '',int page = 1, int limit = 50}) => '/messages/$conID?page=$page&limit=$limit';
  static const String productsAdd = '/products';
  static const String balance = '/wallets/balance';
  static const String sizes = '/sizes';
  static const String colors = '/colors';
  static const String favourites = '/favourites';
  static  String offersAccept(String offerID) => '/offers/$offerID/accept';
  static  String boostPricing(String productID) => '/products/$productID/boost-preview';
  static  String boost(int productID,int days) => '/products/$productID/boosts?days=$days';
  static  String offersReject(String offerID) => '/offers/$offerID/reject';
  static  String offersSend = '/offers/send';
  static const String imageURL = 'https://jidian.merinasib.shop/api/v1/s3/pre-signed-url?fileName=newimage.png&primaryPath=UserUploads&field=User_Profile&expiresIn=900';
  
  /// ================= settings ===========>>>
  static const String termsAndCondition = '/settings/terms_and_condition';
}
