class Constants {
  static const List<String> SUPPORTED_LOCALE = <String>['en', 'ar'];
  static const String BASE_URL = '';
  static const String API_URL = '$BASE_URL/api';
  static const String IMAGE_PLACE_HOLDER = '';
  static const String EG_PHONE_REGEX = r'(010|011|012|015)[0-9]{8}$';
  static const String EMAIL_REGEX =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
}