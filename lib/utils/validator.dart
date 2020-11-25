import 'utils.dart';

class Validator {
  static bool isEGPhoneNumber(String phone) {
    if (phone == null || phone.isEmpty) {
      return false;
    }

    final RegExp exp = RegExp(Constants.EG_PHONE_REGEX);
    return exp.hasMatch(phone);
  }

  static bool isEmail(String email) {
    if (email == null || email.isEmpty) {
      return false;
    }

    final RegExp exp = RegExp(Constants.EMAIL_REGEX);
    return exp.hasMatch(email);
  }

  static bool isSmsCode(String code) {
    return code.length == 5;
  }

  static bool isCodeCorrect(String codeFromUser, String correctCode) {
    if (!Validator.isSmsCode(codeFromUser)) {
      return false;
    }

    final String codeFromUserReversed = codeFromUser.split('').reversed.join();

    if (codeFromUser == correctCode || codeFromUserReversed == correctCode) {
      return true;
    }

    return false;
  }
}