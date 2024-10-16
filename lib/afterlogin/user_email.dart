class UserEmail {
  static final UserEmail _instance = UserEmail._internal();

  String email = 'test1014@naver.com';

  factory UserEmail() {
    return _instance;
  }

  UserEmail._internal();

  void saveEmail(String email) {
    UserEmail().email = email;
  }

  String? getEmail() {
    return UserEmail().email;
  }
}
