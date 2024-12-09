import 'package:mockin/api/login_api.dart';
import 'package:mockin/dto/login/email_auth_dto.dart';
import 'package:mockin/dto/login/send_to_email_dto.dart';
import 'package:mockin/dto/login/signup_dto.dart';
import 'package:mockin/storage/user_email.dart';

class AuthService {
  static bool validateEmail({
    required String email,
  }) {
    final emailPattern1 = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    final emailPattern2 =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (email.isNotEmpty &&
        (emailPattern1.hasMatch(email) || emailPattern2.hasMatch(email))) {
      return true;
    }
    return false;
  }

  static bool isEqualPassword({
    required String password,
    required String checkPassword,
  }) {
    if (password.isNotEmpty &&
        checkPassword.isNotEmpty &&
        (password == checkPassword)) {
      return true;
    }
    return false;
  }

  static Future<bool> sendToEmail({
    required String email,
  }) async {
    var rst = await LoginApi.sendEmail(
      DTO: SendToEmailDTO(
        email: email,
      ),
    );
    if (rst != '-') {
      return true;
    }
    return false;
  }

  static Future<bool> checkEmail({
    required String email,
    required String certified,
  }) async {
    if (certified.isNotEmpty) {
      var rst = await LoginApi.emailCheck(
        DTO: EmailAuthDTO(
          email: email,
          authNum: certified,
        ),
      );
      if (rst != '-') {
        UserEmail().saveEmail(email);
        return true;
      }
    }
    return false;
  }

  static Future<String> signup({
    required String email,
    required String nickName,
    required String password,
  }) async {
    var rst = await LoginApi.userSignUp(
      DTO: SignupDTO(
        email: email,
        pw: password,
        name: nickName,
      ),
    );
    if (rst != '-') {
      return rst;
    }
    return '';
  }
}
